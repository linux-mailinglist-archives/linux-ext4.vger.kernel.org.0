Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBF83B3074
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jun 2021 15:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhFXNvX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Jun 2021 09:51:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46023 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231179AbhFXNvW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Jun 2021 09:51:22 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15ODmxjT018229
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 09:48:59 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2C89415C3CD7; Thu, 24 Jun 2021 09:48:59 -0400 (EDT)
Date:   Thu, 24 Jun 2021 09:48:59 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: fsmap: Fix the block/inode bitmap comment
Message-ID: <YNSNS/iD3G3VxaVK@mit.edu>
References: <e79134132db7ea42f15747b5c669ee91cc1aacdf.1622432690.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e79134132db7ea42f15747b5c669ee91cc1aacdf.1622432690.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 31, 2021 at 09:19:08AM +0530, Ritesh Harjani wrote:
> While debugging fstest ext4/027 failure, found below comment to be wrong and
> confusing. Hence fix it while we are at it.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Applied, thanks.

					- Ted
