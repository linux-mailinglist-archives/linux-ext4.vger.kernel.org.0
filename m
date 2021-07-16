Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6443CB6A8
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jul 2021 13:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhGPLYW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jul 2021 07:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhGPLYI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jul 2021 07:24:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047F6C06175F;
        Fri, 16 Jul 2021 04:21:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id go30so14597749ejc.8;
        Fri, 16 Jul 2021 04:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wnHGNPq7bMhUlKL335UJdlgKd8zJCtv0oGlTguK7nSw=;
        b=cA+tbdv6F7XpqDl72o2wewPUN2YiMDzKu256U/duWC4wjwBxlh2yOtznprANBHl1QS
         uKEzgaXyEQmOPmx3KgxfFf+QYrHNHuxLSJf2fYm8kePBRLC6YpDHVeWZ6RNOJW58EBZL
         eIotZLxZq6Z+KvVsqtMv24HIxV+SQ5tVXdBTpLX74mwmWQ/gEdK+ub6z8+e8T5DJ5kx8
         S5Xqe9bT0cizXx4IaC/S1f4cfRFGlAHyQbXb+UbY11v1Ofs9Y36VENXxYr6HJwoduf7B
         pGi3uwnFvUIphlwprsoDEmaPltdv9VrCfSJWM9H6E3UqAQA7a3WAYmw0s99gnL0qAaEE
         b1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wnHGNPq7bMhUlKL335UJdlgKd8zJCtv0oGlTguK7nSw=;
        b=DCchwOV0jcnFuzSZqXfMhyu3DJszSU4Q6a/gLLwTghh0/Vs4VHtXPyQnFPxaapJr91
         Xczyf02uLILsp1EEU09rKhZmN9+tRhlyaZkxX2OePnuuakNHqedg1qEO7tQokNIE2Tgn
         A+f6q+6Mp+6mN2jYI1KV1IUG4944POMXiTFcT/imWCMwfN4e6l5ncGIxwJNiU/hOXIsF
         qmmwkHVNv8Qa//uF3PHb8nPK80Ixk0/iQ0zDgMzzr6SBVW1IPC2Fr+rBlUHOO6y7REwv
         oCAW9/9m6rgsj97EjWsDlHcf9e50r2isLA8iuNyuYW3dSTkg/08IAFpuu1R4KNerjB2Q
         /1YA==
X-Gm-Message-State: AOAM530xcLbntF82RrPywsc8/h7GumbRG5jXS5Pw8FeG+Iu9YazR2TUE
        B+S6EtdA/bdEJl93xh5GwlI=
X-Google-Smtp-Source: ABdhPJxm01I0Bga4NzRXxvT8TcIGohd/Bb35pB7mXtQapA7n39qnFvgbiVz27xTomBMRUPYTDyrL0A==
X-Received: by 2002:a17:906:af0e:: with SMTP id lx14mr11377132ejb.54.1626434467052;
        Fri, 16 Jul 2021 04:21:07 -0700 (PDT)
Received: from localhost.localdomain ([5.176.51.215])
        by smtp.gmail.com with ESMTPSA id a25sm3590064edr.21.2021.07.16.04.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 04:21:06 -0700 (PDT)
Date:   Fri, 16 Jul 2021 14:20:57 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     syzbot <syzbot+deb25600c2fd79ffd367@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] INFO: task hung in ext4_put_super
Message-ID: <20210716142057.0f1f6045@gmail.com>
In-Reply-To: <000000000000f36f9505c73ae373@google.com>
References: <0000000000006f809f05c284e0f1@google.com>
        <000000000000f36f9505c73ae373@google.com>
X-Mailer: Claws Mail 3.17.8git77 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 16 Jul 2021 03:17:09 -0700
syzbot <syzbot+deb25600c2fd79ffd367@syzkaller.appspotmail.com> wrote:

> syzbot suspects this issue was fixed by commit:
> 
> commit 618f003199c6188e01472b03cdbba227f1dc5f24
> Author: Pavel Skripkin <paskripkin@gmail.com>
> Date:   Fri Apr 30 18:50:46 2021 +0000
> 
>     ext4: fix memory leak in ext4_fill_super
> 
> bisection log:
> https://syzkaller.appspot.com/x/bisect.txt?x=17ebaa22300000 start
> commit:   2f7b98d1e55c Merge tag 'drm-fixes-2021-04-16' of
> git://ano.. git tree:       upstream kernel config:
> https://syzkaller.appspot.com/x/.config?x=398c4d0fe6f66e68 dashboard
> link: https://syzkaller.appspot.com/bug?extid=deb25600c2fd79ffd367
> syz repro:
> https://syzkaller.appspot.com/x/repro.syz?x=170d645ad00000 C
> reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a03a2ed00000
> 
> If the result looks correct, please mark the issue as fixed by
> replying with:
> 
> #syz fix: ext4: fix memory leak in ext4_fill_super
> 
> For information about bisection process see:
> https://goo.gl/tpsmEJ#bisection


This looks correct. I've tested this patch a long time ago, but forgot
to mark it as fixed.

#syz fix: ext4: fix memory leak in ext4_fill_super

 
With regards,
Pavel Skripkin
