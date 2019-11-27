Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55FFB10A799
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2019 01:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfK0AiW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Nov 2019 19:38:22 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40107 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfK0AiW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Nov 2019 19:38:22 -0500
Received: by mail-qk1-f196.google.com with SMTP id a137so16142977qkc.7
        for <linux-ext4@vger.kernel.org>; Tue, 26 Nov 2019 16:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0TC2BOWpRh4jYit4Ff7nyd0NTPThxNCifAyq6VLObY=;
        b=ppixaEv/ZRxvIbeaY1I1rjFRFd0l5mns4YfUBJ1NISqWh5QXd9vsCZqXQUT0TlBRjf
         Qz+6h/1BR1j10vMNebskoTcAq7rco4kZovQgsIw3b9Xw3R9xLOvH61yBx17KptnUL+1p
         puINXZtlsm7B7iMdn3ATMjDx5YpruIQOYJHQih4dBZbeUgK+hylqbiUVBDJ9tCtgQbkg
         zpyvxDrlBB9JH4qUKi77kGbIE0pYLqm+rTFGi1BA/CPpuMHEqLR+v3QHuM//jjxnNDyw
         H2puBRyb7hllPJqhf1KIPeEgqgsSz/Bbstks9g/VgtA855Jt/mDGJe2Vtkd4jzdWDDZD
         Ngtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0TC2BOWpRh4jYit4Ff7nyd0NTPThxNCifAyq6VLObY=;
        b=PfEw0jB8V5VLrgzQWJSo3nnI5j0/h03H/aSsALI+z6lTtlpcOaA8qUwWR8ZxUb/SIN
         0Wx0atfEOm81qDkGBW/G9nG0MirR393lpkOo5DmK4m5aIFTTc2vVCb2Wdv1wqQYRN+1K
         52FmiF+hy+k5ITg8ApYenaz1uUT8gv63ezBt4STJYlgbb4oXuBHDp3U7wzXiPKeM76i+
         2NA3+svJBw87BOkMzxBNqXAD5tp6+Tkahhzu4ZA2HCf2vJRdvNZNpiFH6hz7J+Du42ZG
         C68sVR+Mz+KZbeE+aovMeBQPvG5/Swv478pPAjPPRw1MQqOwxMpyGgu7HMepNQmZNEKz
         nXUQ==
X-Gm-Message-State: APjAAAUClJ5qiGo/cgPcMKDwDZL3lhFwCZc0YTmtHfx/2YOd8qjy20Dn
        yy4a0LdkVGVPTWO7z0gBIzvP/9jhoZ3Q8VedGhDz
X-Google-Smtp-Source: APXvYqwd50hIIUjXB9u1GvjPuBYiICwBU6he4Q0g8dzGlaIMtfRnNCdana3sq7r1R35RMD+GO39gy7puNNeu+A0J0qE=
X-Received: by 2002:a37:e30b:: with SMTP id y11mr1538390qki.12.1574815099644;
 Tue, 26 Nov 2019 16:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20191127001023.63271-1-yzaikin@google.com> <41d22ac8-7907-6bcf-883f-27518506b87f@linuxfoundation.org>
In-Reply-To: <41d22ac8-7907-6bcf-883f-27518506b87f@linuxfoundation.org>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Tue, 26 Nov 2019 16:37:43 -0800
Message-ID: <CAAXuY3qJKDOQumcpwPuuWRa6aPTZNm2-doNy20M45J-1zT8XgQ@mail.gmail.com>
Subject: Re: [PATCH] fs/ext4/inode-test: Fix inode test on 32 bit platforms.
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> Please add Reported-by for Geert and also include the error he is
> seeing in the commit log.
Done
