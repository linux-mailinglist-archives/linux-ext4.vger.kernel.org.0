Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD228B418
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Oct 2020 13:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388243AbgJLLuD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Oct 2020 07:50:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:50084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388118AbgJLLuD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 12 Oct 2020 07:50:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F08D2B251;
        Mon, 12 Oct 2020 11:50:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B50731E12F5; Mon, 12 Oct 2020 13:50:01 +0200 (CEST)
Date:   Mon, 12 Oct 2020 13:50:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Eric Whitney <enwlinux@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: xfstests global-ext4/1k generic/219 failure due to dmesg warning
 of "circular locking dependency detected"
Message-ID: <20201012115001.GD23665@quack2.suse.cz>
References: <2eb09d70-b56e-2c0b-8ef4-0479d7be2bb3@linux.ibm.com>
 <20201012110347.GB23665@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012110347.GB23665@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 12-10-20 13:03:47, Jan Kara wrote:
> Hi!
> 
> On Fri 09-10-20 22:59:13, Ritesh Harjani wrote:
> > While running generic/219 fstests on a 1k blocksize on x86 box, I see
> > below dmesg warning msg and generic/219 fails. I haven't yet analyzed
> > it, but I remember I have seen such warnings before as well in my testing.
> > I was wondering if others have also seen it in their testing or not and
> > if this is any known issue?
> 
> I don't remember seeing this lately. What mkfs options do you use for your
> test? I can see below that mount options are apparently:
> 
> acl,user_xattr,block_validity,usrquota,grpquota

BTW, I've tried and the problem indeed does *not* reproduce in my test KVM
setup with 1k block size and default mkfs options. But it does reproduce
with mkfs option "-O quota". So it indeed seems the lockdep annotation is
somehow broken in this config. I'll have a look...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
