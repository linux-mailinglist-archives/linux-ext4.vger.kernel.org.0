Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E902072F2
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jun 2020 14:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389827AbgFXMLC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Jun 2020 08:11:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:54598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403782AbgFXMLB (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 24 Jun 2020 08:11:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 42BECAED7;
        Wed, 24 Jun 2020 12:11:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 359001E12A8; Wed, 24 Jun 2020 14:11:00 +0200 (CEST)
Date:   Wed, 24 Jun 2020 14:11:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: remove nocheck option
Message-ID: <20200624121100.GA17788@quack2.suse.cz>
References: <20200619073144.4701-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619073144.4701-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 19-06-20 15:31:44, Chengguang Xu wrote:
> Remove useless nocheck option.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Thanks. I've added the patch to my tree.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
