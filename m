Return-Path: <linux-ext4+bounces-3886-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3159095E7A3
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2024 06:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A7A1C21300
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2024 04:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BF481751;
	Mon, 26 Aug 2024 04:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="bdMqW1QJ";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="DCAKlRMw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4515A804
	for <linux-ext4@vger.kernel.org>; Mon, 26 Aug 2024 04:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724646211; cv=none; b=Dfjmw4+SRRpFM1OYrDOOhORiX//uzXJpg7z32uFdeO0WSZhvM0oA5AEk53yRJREsvhjbdyllIL02/ItABWMcmSpsAsxQMq67LopkBMjkJbtQEJuCRw0fwJNOMYE9DlOFFL+ucYx0dY9Zu9U0BJdmzFCG6N8PVhUpE+MtQEkw74Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724646211; c=relaxed/simple;
	bh=UvRwjVT+wdzSsadX45w3gvGTX/NnPXde2PFuhVgMyuk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DjTwm3+G/ESByQa9YpTx9aGHKPC6/6wmd/NzKFdikCCHwW9bE/HnQE2apZqPhxQN7vKIYM0vSmvMTTsDhFHNCZ3A59l3VZndC4zf8Y77hbPyYIY4a4vU3CJLwVMz0u6lZl/KlhXbpqscbTQTxQ8A+GNp4eDjP1BNlURr2J4LKVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=bdMqW1QJ; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=DCAKlRMw; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
DKIM-Signature: a=rsa-sha256; b=bdMqW1QJ2u29NPdmDJUZAq9T9jEztt7DaxcycYXuW6xHuErAhgCIS7HFwWXiD65P4PUNeVoP1ZKIkG6iwZrq8wl6cFCrzcU47rfERSDFWPnnNaWBr4jGVzsvdYGDYDwvV5Ibwo6bkedFsu98ITdPyPYgRHKs84uCLGbG93fE98E/I5a2s+bZXZLhSfdudVEoQ0dPtH8crE8uRo/Ly7GwvtBj++rJ3L99nap9iG3mLr0lOwyl1HLiRn7fJPd9chYoOFGvf4EdM+IzeezuiZSByPwzTWkCuxmJB4mtKKHXEgI24+gllE5peRbVF6gmFODyrYRlD8mthqZAY3ao7inX4w==; s=purelymail2; d=lkcamp.dev; v=1; bh=UvRwjVT+wdzSsadX45w3gvGTX/NnPXde2PFuhVgMyuk=; h=Received:Date:To:Subject:From;
DKIM-Signature: a=rsa-sha256; b=DCAKlRMw9waceTuBQgqwEVY+Xq4gqA7NTLZ9Q0Et1SRF5UXNnbrxbShbMgMAYJ6paQd8GB4cww9wmFHPbjv4D36Y7a6Wv5H1Ociw/PCyz+ybCUd85LyX7R2MfMjNKhihK3Ns19VWFcO+ZcdyMYlzHmFL5fK9tl4cxW5qSBABXYi/mMgMSPfBW8nBfDZ8pFmF+FxwS9o8uTbHowTeZf5Acrx+OF3pupaM+pAv3sNbQpuW7eIcK3YuI4zFcwVucA8p0Gatv0WOUVSLgswe6IeIPC6lISZ4fSB6juf2NOi8qfippDe0j+VyJNpLZfCTOsOPxSZQ0N4AmGXRgkuqb4EkUQ==; s=purelymail2; d=purelymail.com; v=1; bh=UvRwjVT+wdzSsadX45w3gvGTX/NnPXde2PFuhVgMyuk=; h=Feedback-ID:Received:Date:To:Subject:From;
Feedback-ID: 40580:7130:null:purelymail
X-Pm-Original-To: linux-ext4@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1044989440;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 26 Aug 2024 04:22:59 +0000 (UTC)
Message-ID: <d673f289-2385-4949-ac80-f3a502d4deb2@lkcamp.dev>
Date: Mon, 26 Aug 2024 01:22:54 -0300
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+8512f3dbd96253ffbe27@syzkaller.appspotmail.com
Cc: jack@suse.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev, syzkaller-bugs@googlegroups.com, tytso@mit.edu,
 ~lkcamp/discussion@lists.sr.ht
References: <00000000000070a66706204e7698@google.com>
Subject: Re: [syzbot] [ext4?] [ocfs2?] kernel BUG in jbd2_cleanup_journal_tail
Content-Language: en-US
From: Vinicius Peixoto <vpeixoto@lkcamp.dev>
In-Reply-To: <00000000000070a66706204e7698@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I noticed this report from syzbot when going through the preliminary 
tasks for the Linux Kernel Mentorship Program, and thought I'd take a 
stab at solving it. I apologize in advance for any mistakes as I'm still 
very new to kernel development. Either way, here's my analysis:

 From what I can tell by looking at the reproducer from syzbot, it is 
trying to mount a file filled with bogus data as an ocfs2 disk, and this 
is triggering an assertion in jbd2_cleanup_journal_tail, which in turn 
causes a panic.

The problematic call stack goes roughly like this:

mount_bdev
   -> ofcs2_mount_volume
     -> ofcs2_check_volume
       -> ofcs2_journal_load
         -> jbd2_journal_load
           -> journal_reset (fails)

Since the disk data is bogus, journal_reset fails with -EINVAL ("JBD2: 
Journal too short (blocks 2-1024)"); this leaves journal->j_head == 
NULL. However, jbd2_journal_load clears the JBD2_ABORT flag right before 
calling journal_reset. This leads to a problem later when 
ofcs2_mount_volume tries to flush the journal as part of the cleanup 
when aborting the mount operation:

   -> ofcs2_mount_volume (error; goto out_system_inodes)
     -> ofcs2_journal_shutdown
       -> jbd2_journal_flush
         -> jbd2_cleanup_journal_tail (J_ASSERT fails)

This failure happens because of the following code:

         if (is_journal_aborted(journal))
                 return -EIO;

         if (!jbd2_journal_get_log_tail(journal, &first_tid, &blocknr))
                 return 1;
         J_ASSERT(blocknr != 0);

Since JBD2_ABORT was cleared in jbd2_journal_load earlier, we enter 
jbd2_journal_get_log_tail, which will set *blocknr = journal->j_head 
(which is NULL) and then trigger the assertion, causing a panic.

I confirmed that setting the JBD2_ABORT flag in journal_reset before 
returning -EINVAL fixes the problem:

         static int journal_reset(journal_t *journal)
                         journal_fail_superblock(journal);
         +               journal->j_flags |= JBD2_ABORT;
                         return -EINVAL;

You can find a proper patch file + the syzbot re-test result in [1]. 
However, I'm not entirely sure whether this is the correct decision, and 
I wanted to confirm that this is an appropriate solution before sending 
a proper patch to the mailing list.

Thanks in advance,
Vinicius

[1] https://syzkaller.appspot.com/bug?extid=8512f3dbd96253ffbe27


