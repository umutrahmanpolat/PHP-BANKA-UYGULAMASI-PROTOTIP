import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { RouterModule, Routes } from '@angular/router';
import { AppComponent } from './app.component';


import { RegisterComponent } from './auth/register/register.component';
import { CvFormComponent } from './cv/cv-form/cv-form.component';

const routes: Routes = [
  { path: 'kayit', component: RegisterComponent },
  { path: 'cv', component: CvFormComponent },
  { path: '', redirectTo: 'kayit', pathMatch: 'full' },
];

@NgModule({
  declarations: [
    AppComponent,
    RegisterComponent,
    CvFormComponent,
   
  ],
  imports: [
    BrowserModule,
    ReactiveFormsModule,
    HttpClientModule,
    RouterModule.forRoot(routes)
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }