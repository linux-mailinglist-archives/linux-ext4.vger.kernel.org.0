Return-Path: <linux-ext4+bounces-2803-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E37018FF66A
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jun 2024 23:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E43B1F24358
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jun 2024 21:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E41745C0;
	Thu,  6 Jun 2024 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="C1KmBMlN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84D171748
	for <linux-ext4@vger.kernel.org>; Thu,  6 Jun 2024 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717708060; cv=none; b=jlsP9QW9fEOROuBJL03A/kE/sF68APXoUbpaxGwCSZbtr5dHsvgYxK+0tstvpF0etPQCSgMHY/XsI8le3QbRrWmjnVmoag3eIWAY5WCqT9Uppj4GmT21/auExDbchymF2NbBfT21HHcfXKhVltaTYUz9DilgY7I2B84UtVJneSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717708060; c=relaxed/simple;
	bh=kfLw+bVyjNw6GeEFlaVUCx19iTE0rZqESzVAYMUqHgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KU7jsHgv+FBhgWiKAwQ8bCQucmiDqVkWLCvVMaJEc5JaNQy7U47uHeNoulDQvWU6N5AAuq20WAkmQ6xDJfMXh3RyVoszI9Y8q6zABVupkbzhJdTt9q6PmKHiGrmqcz/z5o12A5FSPeSTTLicwkDtPLlJGT6ZHh6S9CfhTNihfws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=C1KmBMlN; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (unn-149-40-50-16.datapacket.com [149.40.50.16] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 456L78xL032294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 17:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1717708036; bh=UyShpUtUk4n/tOAijLCzOMsxjsiHJiQC0A8h/B78v+8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=C1KmBMlNsdZMP0fUtx3mu2tMmvWurhYntomQSE50Kvix41Qfgnjdmyjy7MFc2SHKf
	 QhcOUsLGITIhea0u3PZyMsVUl3y9/fFS9XRJp/T8kFAh71eesmCfF+K/XiunWtGTdV
	 LWtSacRNqpFB4pgzkKEfO8zqrMLvlbK48Alz5bkI80uLGRx5o/lGXCCqagf5C0TA+g
	 FeTc0W0eBvZMo4vvs4GlGPJOQxgdCXdGJmWZpdOnnllMY5OEghZTHTE6pjwbwxuRjg
	 lMrumNWMlO113QPkT666zuWOZ7unNLFpM2/lyrdlZ+zQxVa00k531AUg4l0Au0jcw0
	 DY0luLnAb/JMA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id F33DC340578; Thu, 06 Jun 2024 23:07:06 +0200 (CEST)
Date: Thu, 6 Jun 2024 23:07:06 +0200
From: "Theodore Ts'o" <tytso@mit.edu>
To: =?utf-8?B?0LzQuNGI0LAg0YPRhdC40L0=?= <mish.uxin2012@yandex.ru>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michail Ivanov <iwanov-23@bk.ru>,
        Pavel Koshutin <koshutin.pavel@yandex.ru>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Artem Sadovnikov <ancowi69@gmail.com>
Subject: Re: [PATCH v2] ext4: fix i_data_sem unlock order in
 ext4_ind_migrate()
Message-ID: <20240606210706.GE4182@mit.edu>
References: <20240405210803.9152-1-mish.uxin2012@yandex.ru>
 <20240509145124.GH3620298@mit.edu>
 <3159311717621748@mail.yandex.ru>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3159311717621748@mail.yandex.ru>

On Thu, Jun 06, 2024 at 12:14:22AM +0300, миша ухин wrote:
> <div><div>Thank you for the comment.<br />It seems there might be a misunderstanding.<br />The commit 00d873c17e29 ("ext4: avoid deadlock in fs reclaim with page writeback") you mentioned introduces the use of memalloc_nofs_save()/memalloc_nofs_restore() when acquiring the EXT4_SB(sb)-&gt;s_writepages_rwsem lock.<br />On the other hand the patch we proposed corrects the order of locking/unlocking resources with calls to the functions ext4_journal_start()/ext4_journal_stop() and down_write(&amp;EXT4_I(inode)-&gt;i_data_sem)/up_write(&amp;EXT4_I(inode)-&gt;i_data_sem).<br />These patches do not appear to resolve the same issue, and the code changes are different.</div><div> </div><div>- <span style="white-space:pre-wrap">Mikhail Ukhin</span></div></div>

PLEASE do not send HTML messages to the linux-kernel mailing list.  It
looks like garbage when read on a text mail reader.

In any case, you're correct.  I had misremembered the issue with this
patch.  The complaint that I had made with the V1 of the patch has not
been corrected, which is that the assertion made in the commit
description "the order of unlocking must be the reverse of the order
of locking" is errant nonsense.  It is simply is technically
incorrect; the order in which locks are released doesn't matter.  (And
a jbd2 handle is not a lock.)

The syzkaller report which apparntly triggered this failure was
supplied by Artem here[1], and the explanation should include that it
was triggered by an EXT4_IOC_MIGRATE ioctl which was set to require
synchornous update because the file descriptor was opened with O_SYNC,
and this could result in the jbd2_journal_stop() function calling
jbd2_might_wait_for_commit() which could potentially trigger a
deadlock if the EXT4_IOC_MIGRATE call is racing with write(2) system
call.

[1] https://lore.kernel.org/r/1845977.e0hk0VWMCB@cherry

In any case, this is a low priority issue since the only program which
uses EXT4_IOC_MIGRATE is e4defrag, and it doesn't open files with
O_SYNC, so this isn't going to happen in real life.  And so why don't
you use this as an opportunity to practice writing a technically valid
and correct commit description, and how to properlty submit patches
and send valid (non-HTML) messages to the Linux kernel mailing list?

Cheers,

						- Ted

