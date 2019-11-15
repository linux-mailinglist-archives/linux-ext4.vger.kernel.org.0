Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B08FFFE3AA
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2019 18:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfKORKc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Nov 2019 12:10:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbfKORKb (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 15 Nov 2019 12:10:31 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA76A20728;
        Fri, 15 Nov 2019 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573837831;
        bh=AYpJCtRDeIr/6khByOnwja84+YsEz0CugiiJsz7p4aw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qRFFuxEiTGZWaUfCNAIN7/4jpzJtUkhN+xSjdB3uWkTp4qTSHyNq8o0DS6jPNSdSX
         qMV1uElx+5HKVwgH90rHBkVeOLaNx+lBc7op7P+ug035yvEq+MefRDXnuNdrOCsIrZ
         4XFydWryF6EFYyj8eaoGQAERl/WFxVDadEU08zEM=
Date:   Fri, 15 Nov 2019 09:10:29 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 20/25] jbd2: Reserve space for revoke descriptor blocks
Message-ID: <20191115171029.GA701@sol.localdomain>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191105164437.32602-20-jack@suse.cz>
 <20191115075223.GA152352@sol.localdomain>
 <20191115100222.GC9043@quack2.suse.cz>
 <20191115142033.GA23689@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115142033.GA23689@mit.edu>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 15, 2019 at 09:20:33AM -0500, Theodore Y. Ts'o wrote:
> On Fri, Nov 15, 2019 at 11:02:22AM +0100, Jan Kara wrote:
> > On Thu 14-11-19 23:52:23, Eric Biggers wrote:
> > > On Tue, Nov 05, 2019 at 05:44:26PM +0100, Jan Kara wrote:
> > > >  static inline int jbd2_handle_buffer_credits(handle_t *handle)
> > > >  {
> > > > -	return handle->h_buffer_credits;
> > > > +	journal_t *journal = handle->h_transaction->t_journal;
> > > > +
> > > > +	return handle->h_buffer_credits -
> > > > +		DIV_ROUND_UP(handle->h_revoke_credits_requested,
> > > > +			     journal->j_revoke_records_per_block);
> > > >  }
> > > 
> > > This patch is causing a crash with 'kvm-xfstests -c dioread_nolock ext4/024'.
> > > Looks like this code incorrectly assumes that h_transaction is always valid
> > > rather than the other member of the union, h_journal.
> > 
> > Right, thanks for the report! Just out of curiosity: You have to have that
> > tracepoint enabled for the crash to trigger, don't you? Because I'm pretty
> > sure I did dioread_nolock runs...
> 
> I've been *definitely* been doing dioread_nolock runs (including two
> last night), with no failures.
> 
> ext4/dioread_nolock: 485 tests, 40 skipped, 5142 seconds
> 

No I didn't enable the tracepoint.  I think the difference is that I had
CONFIG_UBSAN enabled.  I get the crash if I use the following kconfig:

	curl -o .config 'https://git.kernel.org/pub/scm/fs/ext2/xfstests-bld.git/plain/kernel-configs/x86_64-config-5.4'
	echo CONFIG_UBSAN=y >> .config
	make olddefconfig

... but not if I don't enable UBSAN.

No idea why UBSAN makes a difference here, though.  I'm using gcc 9.2.0.

- Eric
