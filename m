Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFA632351F
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Feb 2021 02:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhBXBRW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Feb 2021 20:17:22 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36415 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234291AbhBXAnU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 23 Feb 2021 19:43:20 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id AD265C8D
        for <linux-ext4@vger.kernel.org>; Tue, 23 Feb 2021 19:42:02 -0500 (EST)
Received: from imap8 ([10.202.2.58])
  by compute2.internal (MEProxy); Tue, 23 Feb 2021 19:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tinfoilwizard.net; h=mime-version:message-id:date:from:to
        :subject:content-type; s=fm1; bh=OsWDuZesZnGexEiQawNah2K1Quh7bGB
        EoMsBLdNGY0A=; b=UL9do+/IwDIhVqu+lwlVTtlGo9N1dBCIfzkFtWgRvnyc8nS
        ZaHCxPKMX3kDdXg6sbKwJQSmbJgJ6Jd/IQeou3Rq6X1RIHiglhgTqGMzhe1YvBya
        YDcKeTXcm2aBcU8mvz3tzfFa/H0Cu97WzkruyUh42N2FNcHPNVE/6uMam9i0qs+g
        X+AWlIq62QxfLSlZRCqGm+PYVNw93M6/8/3goLUB+Z4QXMkIy+3YML09nnJWKoKT
        Aj2K94BQ6sJaZDwDCVtFeKLO5M/neUcen+q/BWRDq8whfthZJnIumSoP6z8759bq
        pZnVSBR/Wed3aKviNoeQLI7Vs0wRNoZzsLIqs9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=OsWDuZesZnGexEiQawNah2K1Quh7b
        GBEoMsBLdNGY0A=; b=gOljNgRqRhFllmd5NVIe4UXhFcjN98dAQRkWBOp0+YIpH
        YWG8P70NQSlAdjeni0DvRmWr71X24RVaH0w+FFji8OOVyZv+ARRmfoOv4BiCSyiQ
        Onp9thFlRJ4vm4YVzPs9veYrSI/ZvpL3r4N3XwcSW/kCLgJKhtqFneKxzp5RjtDL
        7fKNZ+4wVC4VFbgfEW66F3bpkfv6wMXU9eRMubkPv8qa3nmBq3YtgiEJZK/tn9Mz
        dGDOxSryHraU3ZigPWLNzI71BVBCWvisA3KOU+enArWVxJC3WbfRUMDJKLN3T9Px
        jA6/u1pisCJhSdQA+xOP/3JvPQ6iaxiFH6cWasRJA==
X-ME-Sender: <xms:2aA1YF6RJANPItm_gHHcMop6-FNGKmiFf5Hb8QxZNV4xedykraZ37g>
    <xme:2aA1YC51yv9OXXFqOmjZyIA0XvNN1akS882ykbrSIuWGZGaEyGSOgrfKRa6s-RL1A
    eGJZupRpvb2B8mmKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeeigddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtredtre
    ertdenucfhrhhomhepfdfuvggrmhhushcuvehonhhnohhrfdcuoehsvggrmhhushesthhi
    nhhfohhilhifihiirghrugdrnhgvtheqnecuggftrfgrthhtvghrnhepkefgtdevhfejve
    etleejtdegudeggfehieelkeejteekgefhuedvueehffdutdegnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgvrghmuhhssehtihhnfhhoih
    hlfihiiigrrhgurdhnvght
X-ME-Proxy: <xmx:2aA1YMeQQ7BXvkmPkxPWDLJy4SvSt54xdJZtZraKHJC4JE5IvEmAEQ>
    <xmx:2aA1YOLaLg_8rwYrc7LM5H8cuVmCiJg0et7k2uORcbieFVjwsqb9Dg>
    <xmx:2aA1YJICNpCieWl3P28F09fIsso1Jz2N-sgAqvxzaO8eFNvJiulnVg>
    <xmx:2qA1YOWJ5g6AY7o-7gaZEsI95XwyJrRMAYGWZ0IpFVfghcANur-ucw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C65003A00CA; Tue, 23 Feb 2021 19:42:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-141-gf094924a34-fm-20210210.001-gf094924a
Mime-Version: 1.0
Message-Id: <dccc26c4-19be-4f07-a593-bec842500d09@www.fastmail.com>
Date:   Tue, 23 Feb 2021 16:41:20 -0800
From:   "Seamus Connor" <seamus@tinfoilwizard.net>
To:     linux-ext4@vger.kernel.org
Subject: reproducible corruption in journal
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello All,

I am investigating an issue on our system where a filesystem is becoming corrupt. The underlying block device is provided by us, so we were suspicious that we were screwing something up. However, after gathering a repro of the issue with write logging (a slightly modified version of dm-log-writes), it looks like jbd2 is actually the one running into problems. Up to entry 2979 in our (dm-log-writes) log file, things seem OK:

    $ replay-log --log write_log --replay base_filesystem.ext4.tmp --limit 2979
    $ debugfs base_filesystem.ext4.tmp -f <(echo logdump) | tail
    debugfs 1.44.1 (24-Mar-2018)
    Found expected sequence 12821, type 1 (descriptor block) at block 1791
    Found expected sequence 12821, type 2 (commit block) at block 1795
    Found expected sequence 12822, type 1 (descriptor block) at block 1796
    Found expected sequence 12822, type 2 (commit block) at block 1802
    Found expected sequence 12823, type 1 (descriptor block) at block 1803
    Found expected sequence 12823, type 2 (commit block) at block 1810
    Found expected sequence 12824, type 1 (descriptor block) at block 1811
    Found expected sequence 12824, type 2 (commit block) at block 1815
    Found expected sequence 12825, type 1 (descriptor block) at block 1816
    No magic number at block 1821: end of journal.

However once we replay the next IO things get a little weirder. 

    $ ...--limit 2980 ...
    Found expected sequence 12825, type 2 (commit block) at block 1821
    Found sequence 12824 (not 12826) at block 1822: end of journal.

And finally after replaying the next IO, it looks like a bunch of old entries in the journal get resurrected:

    $ ...--limit 2981 ...
    Found expected sequence 15454, type 1 (descriptor block) at block 15352
    Found expected sequence 15454, type 2 (commit block) at block 15356

If we fsck our filesystem image at IO 2981 or later, we get a bunch of errors. Before that it is clean. IO 2981 touches as single 4k block in inode 8's data blocks. When this corruption was produced, the filesystem is mounted rw,relatime,sync.

This issue is reproduced by our workload, which is a smallish volume of writes every 30 seconds or so. Once the files are written, they are never modified, and are eventually deleted in a rotation style. During a torture test, we disable IO to the underlying block device, and before re-enabling it we fsck the contents of the device. It is here that we detect the corruption. We are detecting a corruption in around 1% of the events here.

Our kernel is based on Ubuntu 16.04's 4.4 series kernel. We have many patches on top of this, but none inside of mm and fs, and none in block that should be relevant. The issue also reproduces on Linux 5.4 + our patch series, though I have not studied any reproductions there.

My next step is to start going though the jbd2 code to figure out how it could be corrupted. Any assistance would be appreciated as I am mostly unfamiliar with this code. Does any one have some pointers at what to look at, or any recollection of similar issues? I can extract more information from the logs if it would help. I am also happy to share the images of the filesystem and the write log if someone wants to look at it.

Thanks,
Seamus
