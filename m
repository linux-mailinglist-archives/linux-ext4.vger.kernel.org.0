Return-Path: <linux-ext4+bounces-2273-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7A98BA5C6
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 05:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D718E1C22718
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 03:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B581F959;
	Fri,  3 May 2024 03:44:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05C157C97
	for <linux-ext4@vger.kernel.org>; Fri,  3 May 2024 03:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714707861; cv=none; b=NtWwwDe9DbFqy5gNNQqVPo2OQnri1p/XtfY2Vh/uqtDN18GvWJGH8J/tb7IJsIKLiXGOszxM3rE3w4QtcETSQFYCWdVbw3QOlj2thUQt7fcxvbx6YJtt5NjsTkzxvk5Oi6YIdq177nX/aUdc495Td+ciqjqjGvi585G/CSw/b2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714707861; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fz7TT3H7DSvBTLyl1OYZpfcRZZ3hzzBpVlW4roVRoje1uk2lRtPZmYVbfMJJI+upsiGWM0gBV7R7nfw8RjGIPi3LWpFZEyX4D3bLXRPAoLk5BHbhGeUqw47BM0yPFArNZUw6m8V9NMqIaEF5n2NMIdMnZOq9WONzjcbR6bowQmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dab89699a8so924956239f.2
        for <linux-ext4@vger.kernel.org>; Thu, 02 May 2024 20:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714707859; x=1715312659;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=RcPXjnn6vvxoNfBjGUcNoQEUo8j8tpWqgpqvx7MOcBLPZQ80cO+jQ2Di1Jf4C6U8iX
         7yY9862zYV4iE9bjTRqCBpGB6g36cEWgoMpffCvwhUqwwm4M3pxg+k9kOH6kwyO+bn/R
         IpdQIFouTzlu/ihluOzaAE6bCeSOCecx7WlBPpaBmdUhvECKZbArM/3NTq8Y1kYigCKx
         86h+dfLnByy/iHDvKkEuMB+tRzvtg7tmNk0VOp6/iHKX+ntHFGfjodolairYxXEs8vLE
         vvfTpvwIlvcustbFS6bUYQEDpnGMsja4i7VxcPI0F5YNnR54G8ohlbBbkK121db7GX16
         VYDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6lb09fiLO4NOtwK9ujsVLhQxvcadz8UHHuVxibwg2z11l7UnDopc7HVUeudxog8eSGYaSOQTezDp4NNl4qsS8cC/QOrCsCKuFrA==
X-Gm-Message-State: AOJu0Yx+o9hDEO76toJlOtuXf+6R/rnXZ/W3DPV0xVMENSchfwkVz7BA
	Q1kbZwMVFqh7VLozTnfPdx5tSdjx4jrVY6UDOpqiuFO+i2nd0A+L+R3EEs5qcnQzEFMZjJmBDlz
	IuuQ3Ll1LxRFQUzXmp/nKG/iKKUNqp7RolUJbk4gzPxscL5usMEry8j8=
X-Google-Smtp-Source: AGHT+IF6jdtVimKJ3sPtIlW6psc1aZK/nSNQxAxNcKk6WGV4mZGOrwytWBePLmVCVM24GexqMQgZkn/SIF5cdqAA9s2wWfiSdIMn
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3f0f:b0:487:5b21:e66f with SMTP id
 ck15-20020a0566383f0f00b004875b21e66fmr65625jab.0.1714707859267; Thu, 02 May
 2024 20:44:19 -0700 (PDT)
Date: Thu, 02 May 2024 20:44:19 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d873390617848870@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

