Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772DD56A58D
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jul 2022 16:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbiGGOgF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jul 2022 10:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiGGOgE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jul 2022 10:36:04 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E66C30F60
        for <linux-ext4@vger.kernel.org>; Thu,  7 Jul 2022 07:36:03 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 267EZx2e003602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Jul 2022 10:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657204560; bh=SAOIFq3O6CqbjKPTbKIk+DMwt2BSx/hEhKrPuLWu3nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kmjuCB2hdJHygiYWq6YJD6aT/XwsPFoVRQoORvYNU0rckcHQqPv1p3aofb8NnRt2o
         ZI71kI+YvAZt7N6HVfNfZHSri4WDUEgwkEyEQUG6fQkZKr/8j86S19aoTjFsxR4Em9
         PkHElycKHgEiDZAi+pcsOzBbCuo5GA2X8RQ8+bf/bAqE8aq1rwT1w+UhK7z2HPLfws
         KE9JtXQOcid3KGAYEKQYNoIWGy/j78vAFGGWnLXzQf47tDB8e2dtkNdsJChZH3JIF2
         fzT3AoT232nYjW7x6eEVBbFZMCIAtRcw3EYWT6FHQZxMOak4KrEk4wPUYOMD9mSiiq
         wRDjaSenF+zpQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7D79715C433D; Thu,  7 Jul 2022 10:35:59 -0400 (EDT)
Date:   Thu, 7 Jul 2022 10:35:59 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/2] ext4: update the s_overhead_clusters in the backup
 sb's when resizing
Message-ID: <YsbvT2585lxFTq9y@mit.edu>
References: <20220629040026.112371-1-tytso@mit.edu>
 <20220629040026.112371-2-tytso@mit.edu>
 <68DC6315-7940-48F8-99D9-D26599819EE3@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68DC6315-7940-48F8-99D9-D26599819EE3@dilger.ca>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 04, 2022 at 02:50:47PM -0600, Andreas Dilger wrote:
> > -void ext4_resize_end(struct super_block *sb)
> > +int ext4_resize_end(struct super_block *sb, bool update_backups)
> > {
> > 	clear_bit_unlock(EXT4_FLAGS_RESIZING, &EXT4_SB(sb)->s_ext4_flags);
> > 	smp_mb__after_atomic();
> > +	if (update_backups)
> > +		return ext4_update_overhead(sb, true);
> > +	else
> > +		return 0;
> 
> (style) no need for "else" after return.

Good point, I'll make that adjustment.

				- Ted
