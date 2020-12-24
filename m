Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD5B2E25FF
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Dec 2020 11:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgLXKy1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Dec 2020 05:54:27 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55612 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbgLXKy0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Dec 2020 05:54:26 -0500
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by linux.microsoft.com (Postfix) with ESMTPSA id 173FC20B6C40
        for <linux-ext4@vger.kernel.org>; Thu, 24 Dec 2020 02:53:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 173FC20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608807226;
        bh=CvF15J5NeJnEF+2DGWEr8d6csci3mlIOMg1/dMqOafg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eyZtlxJQyRzdeWm4UQalEtUMgMjBW4QyBHimAG3yBT+3QxdXzbBPuAO0QEMNgzYVo
         1arw2nkR7+aHPsjzCAtjr44/cWu/CeiulVKcpxPjDp+HC1yN7PUbCHFycwpCzSn0UQ
         qe9eQG/PieQdXPrmQ5DENK95szX6yuV+Zsp2Iit4=
Received: by mail-pg1-f175.google.com with SMTP id n25so1389184pgb.0
        for <linux-ext4@vger.kernel.org>; Thu, 24 Dec 2020 02:53:45 -0800 (PST)
X-Gm-Message-State: AOAM531UCS+gZGGeI14TgOR11b4VOVDyiVjzmZpZfXLVrKp/9idLrtjN
        9mI8ErgNYIGbpYHej6O8naWlUzkdA6Hbev84VZk=
X-Google-Smtp-Source: ABdhPJyC4crEW7I8qlMLDj7uxze6f2JlEyrnbi8U58O2q1JDxeM5Gx36u24HDAs/FMVCRZ5n/k+rGcGwMYmxploOPoA=
X-Received: by 2002:a62:17d0:0:b029:19e:5cf9:a7f6 with SMTP id
 199-20020a6217d00000b029019e5cf9a7f6mr27601591pfx.0.1608807225553; Thu, 24
 Dec 2020 02:53:45 -0800 (PST)
MIME-Version: 1.0
References: <CAFnufp2zSthSbrOQ5JE6rKEANeFqvunCR3W5Bx2VgN_Q3NbLVg@mail.gmail.com>
 <X+AQxkC9MbuxNVRm@mit.edu> <CAFnufp1N-k+MWWsC0G1EhGvzRjiQn3G8qPw=6uqE1wjwnPgmqA@mail.gmail.com>
 <X+If/kAwiaMdaBtF@mit.edu> <CAFnufp1X1B27Dfr_0DUaBNkKhSGmUjBAvPT+tMoQ8JW6b+q03w@mail.gmail.com>
 <X+OIiNOGKmbwITC3@mit.edu> <CAFnufp3u66k5ucSRxxYwrcsPcJOGP25oxCfWFsrVRouQmDNyjA@mail.gmail.com>
 <X+QIC4BpJZNOb7r4@mit.edu>
In-Reply-To: <X+QIC4BpJZNOb7r4@mit.edu>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Thu, 24 Dec 2020 11:53:09 +0100
X-Gmail-Original-Message-ID: <CAFnufp0Z3E2=XACjeXJe7rxe0zj7j9OcckFQ6-LpcEea_Sffhg@mail.gmail.com>
Message-ID: <CAFnufp0Z3E2=XACjeXJe7rxe0zj7j9OcckFQ6-LpcEea_Sffhg@mail.gmail.com>
Subject: Re: discard and data=writeback
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 24, 2020 at 4:16 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Dec 23, 2020 at 07:59:13PM +0100, Matteo Croce wrote:
> >
> > Hi,
> >
> > these are the blktrace outputs for both journaling modes:
>
> Can you send me full trace files (or the outputs of blkparse) so we
> can see what's going on at a somewhat more granular detail?
>
> They'll be huge, so you may need to make them available for download
> from a web server; certainly the vger.kernel.org list server isn't
> going to let an attachment that large through.
>

Hi,

I've created a GDrive link, it should work for everyone:

https://drive.google.com/file/d/1b35hzgUMSnNBZeMNhooFk4rACpNvCZuQ/view?usp=sharing

Cheers,
-- 
per aspera ad upstream
