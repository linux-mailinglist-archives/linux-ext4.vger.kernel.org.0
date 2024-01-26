Return-Path: <linux-ext4+bounces-921-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 909E283D2FD
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 04:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32961B26625
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 03:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18573AD5C;
	Fri, 26 Jan 2024 03:41:14 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739558F6D
	for <linux-ext4@vger.kernel.org>; Fri, 26 Jan 2024 03:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706240473; cv=none; b=V6i8GwFaEZh7/b+4VusguMrNoTDZ/fjmdy/eg+yken3wJiU65KVp/nQscu8gzd88aWlSUKfVoQALDWbSNQNF7ZWyR49c/yDpb/4L46Mfxb8UyzxW0h7K7bxFFG+Hq9uCLn1lOsMCtqPPesCHHf8BJuaFwA/ef194nMigNA8GUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706240473; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=b1k8ChIQSVq8a3qTtsjwi3DQ0uEgVEtKYpb8eCqhxnXQ7QCEBdzEtIhl3KHghvPvcdTJKDz3ePz67HmfgsUgn4xLuuSjRK9rN/tf1Asz+Z8Sa9ntEriQZbOL+gDGhKung5q/i6VJYcUoXdxxl35EZcDuRZgiSkK0MPx5T714Now=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-361a954c3e6so529825ab.0
        for <linux-ext4@vger.kernel.org>; Thu, 25 Jan 2024 19:41:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706240471; x=1706845271;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=LguU7PPwZFQKfeVodp7yp9aNP0X3ngbWBeoAxNyuSY/d+W7+ry9BDka7aauttwP7ZB
         qoy/cqSviXxLv3lZQJXtUqkox8IyrJyDtJShCyrOMSGgz4601QN5cBDQghELZifwmsyB
         YXljOpAEEoTUoZYtHgPkApVmyMFnrNYnzS2qgUcfVp8SIMsiMYe4wRjkaVgOCXkIStZH
         SKYKkNB6gaPtoe7rTe12nU4GMK7Zw3Nk2H1Kj2101CKnMtmfKT8vPa90cr68FjsyY155
         z9H6CXVvWDFGvbZqinx3ksnT4FYElWWQDsnbBPZZQ+1I9XP7u4eSw9LsZ78fBSLIHD59
         D/vg==
X-Gm-Message-State: AOJu0YwOhO9sqZVL1Uk3UM42SVh65Zksl/jJzhL1YcTczn/hW/qcOfTU
	SOXocZzCR89AMt09c/mO/ejDN6SKpyiGjANY8dbFoZjVwtY4ssF78i/ErmWaOlLgl7d/KT+pcQZ
	qIk9gvU8RToojf1E7BbiYpBJhJD7mTQTgJd6X7CsMD0JhGk/puFo5O4U=
X-Google-Smtp-Source: AGHT+IFz0qxmvUVhvPOqgIrXUDDVpxna4jQPfuOBVEfPvyygebPqZl5fDHsA4+R5BZ5kDHAvmukq1PwEVID+8OKOegIa7MVTh2wE
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144b:b0:35f:a338:44ae with SMTP id
 p11-20020a056e02144b00b0035fa33844aemr106434ilo.3.1706240471688; Thu, 25 Jan
 2024 19:41:11 -0800 (PST)
Date: Thu, 25 Jan 2024 19:41:11 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000376be5060fd11135@google.com>
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

