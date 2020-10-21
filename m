Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44ECD29505B
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Oct 2020 18:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502500AbgJUQEZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 12:04:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:56030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502474AbgJUQEY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Oct 2020 12:04:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7612B212;
        Wed, 21 Oct 2020 16:04:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 789E11E0E89; Wed, 21 Oct 2020 18:04:23 +0200 (CEST)
Date:   Wed, 21 Oct 2020 18:04:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH v10 1/9] doc: update ext4 and journalling docs to include
 fast commit feature
Message-ID: <20201021160423.GB25702@quack2.suse.cz>
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
 <20201015203802.3597742-2-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015203802.3597742-2-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 15-10-20 13:37:53, Harshad Shirwadkar wrote:
> +   * - EXT4_FC_TAG_CREAT
> +     - Create directory entry for a newly created file
> +     - ``struct ext4_fc_dentry_info``
> +     - Stores the parent inode numer, inode number and directory entry of the
                                  ^^^ number

> +       newly created file
> +   * - EXT4_FC_TAG_LINK
> +     - Link a directory entry to an inode
> +     - ``struct ext4_fc_dentry_info``
> +     - Stores the parent inode numer, inode number and directory entry
                                  ^^^^ number

BTW, how is EXT4_FC_TAG_CREAT different from EXT4_FC_TAG_LINK? It seems
like they describe essentially the same operation?

> +   * - EXT4_FC_TAG_UNLINK
> +     - Unink a directory entry of an inode
          ^^^^ Unlink

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
