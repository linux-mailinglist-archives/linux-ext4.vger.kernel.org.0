Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3884CF82C3
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2019 23:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfKKWLq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Nov 2019 17:11:46 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44912 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726845AbfKKWLq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Nov 2019 17:11:46 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xABMBSbm023762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 17:11:29 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 785494202FD; Mon, 11 Nov 2019 17:11:28 -0500 (EST)
Date:   Mon, 11 Nov 2019 17:11:28 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     dan.carpenter@oracle.com, jack@suse.cz, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/1] ext4: Add error handling for io_end_vec struct
 allocation
Message-ID: <20191111221128.GA23273@mit.edu>
References: <20191106082505.GA31923@mwanda>
 <20191106093809.10673-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106093809.10673-1-riteshh@linux.ibm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 06, 2019 at 03:08:09PM +0530, Ritesh Harjani wrote:
> This patch adds the error handling in case of any memory allocation
> failure for io_end_vec. This was missing in original
> patch series which enables dioread_nolock for blocksize < pagesize.
> 
> Fixes: c8cc88163f40 ("ext4: Add support for blocksize < pagesize in dioread_nolock")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Applied, thanks.

					- Ted
