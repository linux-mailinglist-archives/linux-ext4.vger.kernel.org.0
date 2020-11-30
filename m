Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744582C9191
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Nov 2020 23:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbgK3Wvl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Nov 2020 17:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388132AbgK3Wvk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Nov 2020 17:51:40 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2E5C0617A6
        for <linux-ext4@vger.kernel.org>; Mon, 30 Nov 2020 14:50:21 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id j10so20753963lja.5
        for <linux-ext4@vger.kernel.org>; Mon, 30 Nov 2020 14:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1bDJzC+7/EeDz8Z4TYtcl8pVmXB1VZfQyZ+oFPIZuXs=;
        b=FjoZwlqRl25v3f0bwesiLG6VMDJ0cdT+WZsk9oJG7qotZdfQy3Bnzm/ErkRC6KEF0Q
         V8tXzsGFOERVPlB9fDDUrXunF4OR96Byp7o91ITmQ4f6ghX4OplZA9VRfMBWotgDeDXS
         4fMHVDZZFkLBQZtMZ9inRIOYwvw2PRu8hX+wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1bDJzC+7/EeDz8Z4TYtcl8pVmXB1VZfQyZ+oFPIZuXs=;
        b=bOq57Jc5dWgxul37XFtkG1f+jK8hWalw58GuQG0NbDMeeV++zGOjY7gOLqij9PCWYT
         WAGcjVIIQY/FBK9HvWPQUqur/kG5B45MVe0Nzid2978WPcibX3iBjn3gZ9y85LEHsusg
         RjsqRf6gBLmhQ4zx7PSOeW26DrkhgUx4KlJiYnuEvWBxn3PvRzZf75vLFnChMnqOXx+T
         dwd+ufPXqxBvBAQkYR1oWOFiNrUnAiMlKzyba2azhQWKTOTu3cwqWYyj6YSQYsVOk8rN
         un93b5pEgO8CGLCH/IRy0nXBeyRRwk1BJvjlAWJfF7rz5QFi9rhJo203HGlR7KwAzI7P
         am+A==
X-Gm-Message-State: AOAM531ukPzDtA7hebnez3k35IELVPAsw+QiXt8TI2tetY1T3qcT+ie8
        GHtl9nbq+ifKONHcaXilUD+CIT/nkiZY0gvUwmQkmQ==
X-Google-Smtp-Source: ABdhPJyMsQBDmsS07l72ppmPq7n5DMn6hdGTx4GyLQK7ar2TSxkO0y0Q1aohyJmtrB+4dMWzWOlvHMr1zq5pbE7LHlg=
X-Received: by 2002:a2e:b386:: with SMTP id f6mr10646917lje.320.1606776619482;
 Mon, 30 Nov 2020 14:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20201128213527.2669807-1-christian.brauner@ubuntu.com> <20201128213527.2669807-33-christian.brauner@ubuntu.com>
In-Reply-To: <20201128213527.2669807-33-christian.brauner@ubuntu.com>
From:   =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Date:   Mon, 30 Nov 2020 17:50:08 -0500
Message-ID: <CAHap4zu3wjCqjbxaXbsPqz2Q_oNRm0Q=xQMudPStwN8h92Stcw@mail.gmail.com>
Subject: Re: [PATCH v3 32/38] fat: handle idmapped mounts
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        containers@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>, smbarber@chromium.org,
        linux-ext4@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, selinux@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        David Howells <dhowells@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Theodore Tso <tytso@mit.edu>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        fstests@vger.kernel.org, linux-security-module@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Alban Crequy <alban@kinvolk.io>,
        linux-integrity@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

>
> mount2 --idmap both:1000:1001:1
>

Nit: missing arguments to mount2.
