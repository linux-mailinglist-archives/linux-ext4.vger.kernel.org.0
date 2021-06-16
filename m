Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5803AA77C
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jun 2021 01:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhFPXcu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 19:32:50 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60871 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234508AbhFPXcu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Jun 2021 19:32:50 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15GNUbU7032395
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 19:30:37 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3C13115C3CB8; Wed, 16 Jun 2021 19:30:37 -0400 (EDT)
Date:   Wed, 16 Jun 2021 19:30:37 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Remove redundant assignment to error
Message-ID: <YMqJnVr9nkxG3o5n@mit.edu>
References: <1619691409-83160-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619691409-83160-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 29, 2021 at 06:16:49PM +0800, Jiapeng Chong wrote:
> Variable error is set to zero but this value is never read as it's not
> used later on, hence it is a redundant assignment and can be removed.
> 
> Cleans up the following clang-analyzer warning:
> 
> fs/ext4/ioctl.c:657:3: warning: Value stored to 'error' is never read
> [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied, thanks.

					- Ted
