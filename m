Return-Path: <linux-ext4+bounces-848-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B29832277
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jan 2024 01:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC72F1C229C5
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jan 2024 00:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D80A656;
	Fri, 19 Jan 2024 00:08:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8638E
	for <linux-ext4@vger.kernel.org>; Fri, 19 Jan 2024 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705622893; cv=none; b=GX2Wwnf3d3A4DYI0iy035KcRsXtwB1v+O2s74+Pkab8aRPBtmiqCHMSE7rShZpisWCE5Rw35AlzE/SdmQjYYokxMv+MfzUAJd7/6gzPzpSA8PLy0czs0/WW/gz6nriFuCqoSg8/Z4OdPxno4H/kb7LzSGOcKiJNPb/enlEe6wA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705622893; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Alv5ZRrVBOtYRh4ootw8fYZNRYG3gk8Es+FMK4LZNuzkP/N0/jPfpGO6uwHsK7FFdIRSTVz3sGO4G45P6lkzRRTY/hlupuBOyV15DVxgr05ni0qvqyJQrMbKGLBd/0yw+Jm1LmDTSVeCSrKjRO2etHIglAajCMO5QLmImYdJx1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bef780be70so22720639f.0
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jan 2024 16:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705622890; x=1706227690;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=rbqEZ0HvT2FSdkpb7N3PhayLjlaJw0oqCm2ijbSGfJfpSgPGG0xNhFoq6lc06Ncvyb
         N3fIZLfitNxtOqcvPCeC6JHluyyeSxWUvHEOuiATa9HDalQO9cBBlEw8UwNxX83fwXde
         o8t/+Og/mH8EZirvUSPo9Lh4Xk4O4yb79xexojp9QAO2TW2k28nXTTa/AWXe4wqA4S7X
         JmpmtQJ0xmMc4MX1AATwygZeGu0QPcN8jCR1N9vqc5ObBN9Mx9c9PKigxvvRXZ9Eb9CI
         H5mRsl4VUxEPT5/hRtTwufUF1BCmEKN6IbTccon/ZvBcpsFkB+J10DM8z4ddVf0WZ7mK
         bOEg==
X-Gm-Message-State: AOJu0Yw/u2sjZHMMpsLXFuEtQUMWKabpwYUef/gwRYo7stlL7WCMRK50
	tkz0w0zA3Rvfziv1suwewaoLb6ziN5RV2H7HD/zpip9IwlWoWXScEjKDRiwa8znhdviCWlOG3ip
	3P35ohrQdTQ8amd1MGmIuxkBzkiuMd710J6MEBJzbwF9J/W8FcNH7mUE=
X-Google-Smtp-Source: AGHT+IE+20ODISW063pUWTzU3qYgT+tD4QbDYTdBWXIP3yqFphYyDanVroxowDzV4LV9aaQmKl8KVb83SSsvWZJB9EKHizymSZ3r
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8c:0:b0:361:9826:5209 with SMTP id
 r12-20020a92cd8c000000b0036198265209mr179106ilb.0.1705622890710; Thu, 18 Jan
 2024 16:08:10 -0800 (PST)
Date: Thu, 18 Jan 2024 16:08:10 -0800
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085902f060f414615@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From: syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48

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

