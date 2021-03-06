// @flow
import axios from 'axios';
import authenticityToken from './authenticityToken';

const axiosClient = axios.create({
  withCredentials: true,
});

axiosClient.interceptors.request.use(
  (config: Object) => {
    config.headers['X-CSRF-TOKEN'] = authenticityToken();  // eslint-disable-line
    return config;
  },
  error => Promise.reject(error),
);

function get(url: string, params: any = {}) {
  return axiosClient.get(url, params).then(response => response.data);
}

function sendDelete(url: string) {
  return axiosClient.delete(url).then(response => response.data);
}

function sendPatch(url: string, data: Object) {
  return axiosClient.patch(url, data).then(response => response.data);
}

function sendPost(url: string, data: Object) {
  return axiosClient.post(url, data).then(response => response.data);
}

export function quizzes() {
  return get('/api/quizzes');
}

export function createQuiz(values: { title: string, description: string }) {
  return sendPost('/api/quizzes', { quiz: values });
}

export function updateQuiz(quizId: string, values: { title: string, description: string }) {
  return sendPatch(`/api/quizzes/${quizId}`, { quiz: values });
}

export function deleteQuiz(quizId: string) {
  return sendDelete(`/api/quizzes/${quizId}`);
}

export function myQuizzes() {
  return get('/api/users/quizzes');
}

export function myQuiz(id: string) {
  return get(`/api/users/quizzes/${id}`);
}

export function createQuestion(quizId: string, values: { content: string, answer_content: string}) {
  return sendPost(`/api/users/quizzes/${quizId}/questions`, { question: values });
}

export function updateQuestion(questionId: string, values: { content: string, answer_content: string}) {
  return sendPatch(`/api/users/questions/${questionId}`, { question: values });
}

export function deleteQuestion(questionId: string) {
  return sendDelete(`/api/users/questions/${questionId}`);
}

export function startQuizTrial(quizId: string) {
  return sendPost(`/api/quizzes/${quizId}/quiz_trials`, {});
}

export function getQuizTrial(quizTrialId: string) {
  return get(`/api/quiz_trials/${quizTrialId}`);
}

export function submitQuizTrialAnswer(quizTrialId: string, values: { content: string, questionId: string }) {
  return sendPost(`/api/quiz_trials/${quizTrialId}/user_answers`, { user_answer: values });
}

export function userAnswer(id: number) {
  return get(`/api/user_answers/${id}`);
}

export function quizTrialResult(id: number) {
  return get(`/api/quiz_trials/${id}/result`);
}

export function logOut() {
  return sendDelete('/api/session');
}
