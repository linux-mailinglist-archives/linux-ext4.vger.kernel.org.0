Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E4328E393
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Oct 2020 17:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgJNPuJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Oct 2020 11:50:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35502 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726439AbgJNPuJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Oct 2020 11:50:09 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09EFmwME024420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 11:48:59 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8F375420107; Wed, 14 Oct 2020 11:48:58 -0400 (EDT)
Date:   Wed, 14 Oct 2020 11:48:58 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     xiakaixu1987@gmail.com, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [RFC PATCH] ext4: use the normal helper to get the actual inode
Message-ID: <20201014154858.GC18373@mit.edu>
References: <1602317416-1260-1-git-send-email-kaixuxia@tencent.com>
 <20201012093304.aevqpvq5sotzamrq@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012093304.aevqpvq5sotzamrq@work>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 12, 2020 at 11:33:04AM +0200, Lukas Czerner wrote:
> On Sat, Oct 10, 2020 at 04:10:16PM +0800, xiakaixu1987@gmail.com wrote:
> > From: Kaixu Xia <kaixuxia@tencent.com>
> > 
> > Here we use the READ_ONCE to fix race conditions in ->d_compare() and
> > ->d_hash() when they are called in RCU-walk mode, seems we can use
> > the normal helper d_inode_rcu() to get the actual inode.
> 
> Looks good to me.
> Thanks!
> 
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Thanks, applied.

				- Ted
