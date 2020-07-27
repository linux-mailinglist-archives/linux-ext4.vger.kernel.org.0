Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C255B22EA91
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 12:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgG0K7b (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 06:59:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:47356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbgG0K7a (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Jul 2020 06:59:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 09B1DAC12;
        Mon, 27 Jul 2020 10:59:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A010F1E12C5; Mon, 27 Jul 2020 12:59:29 +0200 (CEST)
Date:   Mon, 27 Jul 2020 12:59:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>,
        Wolfgang Frisch <wolfgang.frisch@suse.com>
Subject: Re: [PATCH 3/4] ext4: Check journal inode extents more carefully
Message-ID: <20200727105929.GL23179@quack2.suse.cz>
References: <20200715131812.7243-1-jack@suse.cz>
 <20200715131812.7243-4-jack@suse.cz>
 <20200721103855.c5a6ki32ocpe2nwe@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721103855.c5a6ki32ocpe2nwe@work>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 21-07-20 12:38:55, Lukas Czerner wrote:
> > @@ -270,19 +272,19 @@ int ext4_setup_system_zone(struct super_block *sb)
> >  		    ((i < 5) || ((i % flex_size) == 0)))
> >  			add_system_zone(system_blks,
> >  					ext4_group_first_block_no(sb, i),
> > -					ext4_bg_num_gdb(sb, i) + 1);
> > +					ext4_bg_num_gdb(sb, i) + 1, 0);
> 
> Is there a good reason we don't check the return value, it can still
> fail right ?

Yes, it can. I'll add a patch to the series that fixes this.

> Other than that the patch looks good to me.
> 
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Thanks for review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
