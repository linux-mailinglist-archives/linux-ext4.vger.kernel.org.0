Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA322105986
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2019 19:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKUS3X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Nov 2019 13:29:23 -0500
Received: from outgoing-auth-2.mit.edu ([18.7.34.11]:53288 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726279AbfKUS3X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Nov 2019 13:29:23 -0500
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Nov 2019 13:29:22 EST
Received: from callcc.thunk.org (guestnat-104-133-8-103.corp.google.com [104.133.8.103] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xALIMgeA032373
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Nov 2019 13:22:43 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0986A4202FD; Thu, 21 Nov 2019 13:22:40 -0500 (EST)
Date:   Thu, 21 Nov 2019 13:22:40 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        eric.saint.etienne@oracle.com
Subject: Re: [PATCH] tune2fs: prohibit toggling uninit_bg on live filesystems
Message-ID: <20191121182240.GJ4262@mit.edu>
References: <20191120193255.GF6213@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120193255.GF6213@magnolia>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 20, 2019 at 11:32:55AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> An internal customer followed an erroneous AskUbuntu article[1] to try to
> change the UUID of a live ext4 filesystem.  The article claims that you
> can work around tune2fs' "cannot change UUID on live fs" error by
> disabling uninit_bg, changing the UUID, and re-enabling the feature.
> 
> This led to metadata corruption because tune2fs' journal descriptor
> rewrite races with regular filesystem writes.  Therefore, prevent
> administrators from turning on or off uninit_bg on a mounted fs.
> 
> [1] https://askubuntu.com/questions/132079/how-do-i-change-uuid-of-a-disk-to-whatever-i-want/195839#459097
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks, applied.

					- Ted
