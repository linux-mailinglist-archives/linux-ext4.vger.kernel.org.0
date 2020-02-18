Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 587DE162B48
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Feb 2020 18:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBRRE7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Feb 2020 12:04:59 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60274 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726399AbgBRRE7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Feb 2020 12:04:59 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01IH4h7a017263
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Feb 2020 12:04:45 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AC3654211EF; Tue, 18 Feb 2020 12:04:42 -0500 (EST)
Date:   Tue, 18 Feb 2020 12:04:42 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        luoshijie1@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH v3 2/2] jbd2: do not clear the BH_Mapped flag when
 forgetting a metadata buffer
Message-ID: <20200218170442.GC147128@mit.edu>
References: <20200213063821.30455-1-yi.zhang@huawei.com>
 <20200213063821.30455-3-yi.zhang@huawei.com>
 <20200217093645.GC12032@quack2.suse.cz>
 <dcdd498d-68b4-360c-f0f1-3ee72ac0c1ad@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcdd498d-68b4-360c-f0f1-3ee72ac0c1ad@huawei.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 17, 2020 at 06:38:23PM +0800, zhangyi (F) wrote:
> >> +			/*
> >> +			 * Block device buffers need to stay mapped all the
> >> +			 * time, so it is enough to clear buffer_jbddirty and
> >> +			 * buffer_freed bits. For the file mapping buffers (i.e.
> >> +			 * journalled data) we need to unmap buffer and clear
> >> +			 * more bits. We also need to be careful about the check
> >> +			 * because the data page mapping can get cleared under
> >> +			 * out hands, which alse need not to clear more bits
> > 			   ^^^ our    ^^^^ Maybe I'd rephrase this like:
> > 
> > ... under our hands. Note that if mapping == NULL, we don't need to make
> > buffer unmapped because the page is already detached from the mapping and
> > buffers cannot get reused.
> > 
> Thanks for your suggestion, Ted has already pushed this patch to upstream,
> I could write an appending patch to fix this.

Feel free to send a patch to fix up the comment if you like.

Thanks,

					- Ted
