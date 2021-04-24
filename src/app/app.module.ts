import { BrowserModule } from '@angular/platform-browser';
import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './login/login.component';

import { AuthModule } from '@auth0/auth0-angular'

import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { AngularMaterialModule } from './angular-material.module'


@NgModule({
  declarations: [
    AppComponent,
    LoginComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    AngularMaterialModule,
    AuthModule.forRoot({
      domain: 'cloudcomputingassociates.auth0.com',
      clientId: 'JaSg29de0IyNdsjc5dbndYMyln4TwQj9'
    })
  ],
  providers: [],
  bootstrap: [AppComponent],
  exports: [LoginComponent]
})
export class AppModule { }
