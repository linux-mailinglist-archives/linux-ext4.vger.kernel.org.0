Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4A03BFAAD
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jul 2021 14:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhGHMxx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jul 2021 08:53:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49453 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231716AbhGHMxx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Jul 2021 08:53:53 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 168Cp7hR032627
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jul 2021 08:51:07 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D3EFF15C3CC6; Thu,  8 Jul 2021 08:51:06 -0400 (EDT)
Date:   Thu, 8 Jul 2021 08:51:06 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/9] ext4/003: Fix this test on 64K platform for dax
 config
Message-ID: <YOb0uklBx0NOLKG3@mit.edu>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
 <fda7d76b27234a46c3e7165fbdfc4154708c227d.1623651783.git.riteshh@linux.ibm.com>
 <YNybadzpnZZdwtzR@mit.edu>
 <20210708062445.xnoij6ya7huedqcv@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708062445.xnoij6ya7huedqcv@riteshh-domain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 08, 2021 at 11:54:45AM +0530, Ritesh Harjani wrote:
> Yes, thanks for catching it. I think if make below change, i.e. scale cluster
> size, we should be good. Since this will make blocks_per_group = 4096 and
> clusters_per_group = 256. This is the condition, which I guess the original
> kernel patch fixed it for. So, we need not increase the filesystem size.
> 
> $MKFS_EXT4_PROG -F -b $BLOCK_SIZE -O bigalloc -C $((BLOCK_SIZE * 16))  -g 256 $SCRATCH_DEV 512m \
>

Agreed, it looks like that should work.

Cheers,

					- Ted
