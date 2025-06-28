import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({ providedIn: 'root' })
export class ApiService {
  private baseUrl = 'http://localhost/backend/';

  constructor(private http: HttpClient) {}

  register(data: any) {
    return this.http.post(this.baseUrl + 'register.php', data);
  }

  login(data: any) {
    return this.http.post(this.baseUrl + 'login.php', data);
  }

  saveCV(data: any) {
    return this.http.post(this.baseUrl + 'save_cv.php', data);
  }
}
