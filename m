Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C286174A22
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2020 00:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgB2X3g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 29 Feb 2020 18:29:36 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57445 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726786AbgB2X3g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 29 Feb 2020 18:29:36 -0500
Received: from callcc.thunk.org (205.220.128.199.nw.nuvox.net [205.220.128.199])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01TNTF3h004833
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Feb 2020 18:29:29 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E081B42045B; Sat, 29 Feb 2020 18:29:14 -0500 (EST)
Date:   Sat, 29 Feb 2020 18:29:14 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@whamcloud.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/9] e2fsck: reduce memory usage for many directories
Message-ID: <20200229232914.GD38945@mit.edu>
References: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
 <1581037786-62789-4-git-send-email-adilger@whamcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581037786-62789-4-git-send-email-adilger@whamcloud.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 06, 2020 at 06:09:41PM -0700, Andreas Dilger wrote:
> Pack struct dx_dir_info and dx_dirblock_info properly in memory, to
> avoid holes, and fields are not larger than necessary.  This reduces
> the memory needed for each hashed dir, according to pahole(1) from:
> 
>     struct dx_dir_info {
>         /* size: 32, cachelines: 1, members: 6 */
>         /* sum members: 26, holes: 1, sum holes: 2 */
>         /* padding: 4 */
>     };
>     struct dx_dirblock_info {
>         /* size: 56, cachelines: 1, members: 9 */
>         /* sum members: 48, holes: 2, sum holes: 8 */
>         /* last cacheline: 56 bytes */
>     };
> 
> to 8 bytes less for each directory and directory block, and leaves
> space for future use if needed (e.g. larger numblocks):
> 
>     struct dx_dir_info {
>         /* size: 24, cachelines: 1, members: 6 */
>         /* sum members: 20, holes: 1, sum holes: 4 */
>         /* bit holes: 1, sum bit holes: 7 bits */
>     };
>     struct dx_dirblock_info {
>         /* size: 48, cachelines: 1, members: 9 */
>     };
> 
> Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
> Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13197

Applied, thanks.

					- Ted
