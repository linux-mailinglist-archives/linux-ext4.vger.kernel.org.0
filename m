Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DDE484CF2
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jan 2022 04:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbiAEDwg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jan 2022 22:52:36 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50207 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230284AbiAEDwf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jan 2022 22:52:35 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2053qUVM011009
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jan 2022 22:52:31 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A9D4415C00E1; Tue,  4 Jan 2022 22:52:30 -0500 (EST)
Date:   Tue, 4 Jan 2022 22:52:30 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, adilger@dilger.ca
Subject: Re: [PATCH 1/2] ext4: Change s_last_trim_minblks type to unsigned
 long
Message-ID: <YdUV/pYn1DP/ECKz@mit.edu>
References: <20211103145122.17338-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103145122.17338-1-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 03, 2021 at 03:51:21PM +0100, Lukas Czerner wrote:
> There is no good reason for the s_last_trim_minblks to be atomic. There is
> no data integrity needed and there is no real danger in setting and
> reading it in a racy manner. Change it to be unsigned long, the same type
> as s_clusters_per_group which is the maximum that's allowed.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Suggested-by: Andreas Dilger <adilger@dilger.ca>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks, applied.

					- Ted
