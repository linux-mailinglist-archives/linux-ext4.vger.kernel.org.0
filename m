Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A643940D1E5
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Sep 2021 05:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhIPDCy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Sep 2021 23:02:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40835 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233961AbhIPDCr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Sep 2021 23:02:47 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 18G31IVP017850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 23:01:18 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1962815C3427; Wed, 15 Sep 2021 23:01:18 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>, adilger.kernel@dilger.ca
Cc:     "Theodore Ts'o" <tytso@mit.edu>, joseph.qi@linux.alibaba.com,
        linux-ext4@vger.kernel.org, hsiangkao@linux.alibaba.com,
        enwlinux@gmail.com
Subject: Re: [PATCH v2] ext4: fix reserved space counter leakage
Date:   Wed, 15 Sep 2021 23:01:12 -0400
Message-Id: <163176124738.2478144.17001941380733337.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210823061358.84473-1-jefflexu@linux.alibaba.com>
References: <20210823061358.84473-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 23 Aug 2021 14:13:58 +0800, Jeffle Xu wrote:
> When ext4_insert_delayed block receives and recovers from an error from
> ext4_es_insert_delayed_block(), e.g., ENOMEM, it does not release the
> space it has reserved for that block insertion as it should. One effect
> of this bug is that s_dirtyclusters_counter is not decremented and
> remains incorrectly elevated until the file system has been unmounted.
> This can result in premature ENOSPC returns and apparent loss of free
> space.
> 
> [...]

Applied, thanks!

[1/1] ext4: fix reserved space counter leakage
      commit: 8ec5146a46609a89658e5dc9bc40b70ce70ef43b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
