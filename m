Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF31123D674
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Aug 2020 07:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgHFFia (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Aug 2020 01:38:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48296 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbgHFFia (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Aug 2020 01:38:30 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0765cO92030075
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Aug 2020 01:38:25 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CD2B7420263; Thu,  6 Aug 2020 01:38:24 -0400 (EDT)
Date:   Thu, 6 Aug 2020 01:38:24 -0400
From:   tytso@mit.edu
To:     brookxu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: ext4: fix spelling typos in ext4_mb_initialize_context
Message-ID: <20200806053824.GK7657@mit.edu>
References: <883b523c-58ec-7f38-0bb8-cd2ea4393684@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <883b523c-58ec-7f38-0bb8-cd2ea4393684@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 15, 2020 at 11:00:44AM +0800, brookxu wrote:
> Fix spelling typos in ext4_mb_initialize_context.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Thanks, applied.

					- Ted
