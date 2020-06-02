Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963021EBBED
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jun 2020 14:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgFBMlr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Jun 2020 08:41:47 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:40919 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgFBMlq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Jun 2020 08:41:46 -0400
Received: by mail-il1-f200.google.com with SMTP id s4so9043952ilc.7
        for <linux-ext4@vger.kernel.org>; Tue, 02 Jun 2020 05:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=tAlIbuV2NmJbjQsrEd8aARaADyAiwp04Ya0IbnrBnn0=;
        b=Wd1k2AAm5SiG4sOxjMrvPUpW8QYuoAOletgTZCxNyv1Tb+l2TGKn/3unxrjGam2fKo
         RxlMzIQRbYuSf2GxreXse339xPL2zYCNsyPRywAeZiuaiC5aMCpnZ3HhwSWrlJLWlXk6
         6Aw39ZR/gS0TrlSccbliZfJM+6dJ8LYvJSNCvGQ5W9u7ogwjfejQrcOEmJNPaxwLe0NF
         iJAf+ndvayHJEors6Vc5zqXdORGXed3WklMm9cvwAfFAzVs1/a/73XvxjgYn27V15Oya
         2mBZm4NhgBsVP3CueBIEgBNAWuk4M9ZnhrLuPzmcS7HEG1C3QxYqCwVkfhyMc3UhKnmR
         2dAg==
X-Gm-Message-State: AOAM5311VHWQsbh1XOB/1LD0uqRiUbSRLPMMVUhbtih0Q5w1q8J07pPr
        /x3d8hYb0o8Jc7LOiYGZRLDJnFmJkhOQAQnGyJkqcv0A8cPE
X-Google-Smtp-Source: ABdhPJy0duXvd9nJwf4jJ+gZCXXpt1+wEmsQ8/kmPREsBEIwiOWpnsvild1FxcJtKuX5Yj6pRJyHODOemxR+emeQ45aoT2uGgm3p
MIME-Version: 1.0
X-Received: by 2002:a02:ce56:: with SMTP id y22mr25228557jar.18.1591101704812;
 Tue, 02 Jun 2020 05:41:44 -0700 (PDT)
Date:   Tue, 02 Jun 2020 05:41:44 -0700
In-Reply-To: <20200602124130.256274203F@d06av24.portsmouth.uk.ibm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eabc7505a7193b6a@google.com>
Subject: Re: Re: linux-next test error: BUG: using smp_processor_id() in
 preemptible [ADDR] code: syz-fuzzer/6792
From:   syzbot <syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        riteshh@linux.ibm.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> #syz test: 

This crash does not have a reproducer. I cannot test it.

> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 
> 0e21d4620dd047da7952f44a2e1ac777ded2d57e
