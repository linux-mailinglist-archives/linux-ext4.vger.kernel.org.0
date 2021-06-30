Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA253B8714
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 18:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhF3QcO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 12:32:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35079 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229510AbhF3QcN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Jun 2021 12:32:13 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15UGTe4K004092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 12:29:41 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8D79415C3C8E; Wed, 30 Jun 2021 12:29:40 -0400 (EDT)
Date:   Wed, 30 Jun 2021 12:29:40 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/9] ext4/306: Add -b blocksize parameter too to avoid
 failure with DAX config
Message-ID: <YNyb9Ey1nlalA8Z9@mit.edu>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
 <280020a9d6791ad4fc1c51bef9c20771f6791d69.1623651783.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <280020a9d6791ad4fc1c51bef9c20771f6791d69.1623651783.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 14, 2021 at 11:58:07AM +0530, Ritesh Harjani wrote:
> mkfs.ext4 by default uses 4K blocksize. On DAX config with a 64K
> pagesize platform (PPC64), this will fail to mount since DAX requires bs
> == ps.
> Hence add the -b blocksize paramter in ext4/306.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good, thanks.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

					- Ted
