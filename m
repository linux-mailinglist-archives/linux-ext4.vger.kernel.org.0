Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DEA28013F
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Oct 2020 16:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbgJAO0m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Oct 2020 10:26:42 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50850 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732099AbgJAO0m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Oct 2020 10:26:42 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 091EQbh6029126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Oct 2020 10:26:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A46AA42003C; Thu,  1 Oct 2020 10:26:37 -0400 (EDT)
Date:   Thu, 1 Oct 2020 10:26:37 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>
Subject: Re: [PATCH] tune2fs: reset MMP state on error exit
Message-ID: <20201001142637.GG23474@mit.edu>
References: <20200617114049.93821-1-adilger@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617114049.93821-1-adilger@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 17, 2020 at 05:40:49AM -0600, Andreas Dilger wrote:
> From: Andreas Dilger <adilger@whamcloud.com>
> 
> If tune2fs cannot perform the requested change, ensure that the MMP
> block is reset to the unused state before exiting.  Otherwise, the
> filesystem will be left with mmp_seq = EXT4_MMP_SEQ_FSCK set, which
> prevents it from being mounted afterward:
> 
>     EXT4-fs warning (device dm-9): ext4_multi_mount_protect:311:
>         fsck is running on the filesystem
> 
> Add a test to try some failed tune2fs operations and verify that the
> MMP block is left in a clean state afterward.
> 
> Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13672
> Signed-off-by: Andreas Dilger <adilger@whamcloud.com>

Applied, thanks.

					- Ted
