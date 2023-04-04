Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53DA6D70C8
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 01:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbjDDXhS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Apr 2023 19:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjDDXhR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Apr 2023 19:37:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81831736;
        Tue,  4 Apr 2023 16:37:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F20963ABF;
        Tue,  4 Apr 2023 23:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D67C433EF;
        Tue,  4 Apr 2023 23:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680651435;
        bh=28csmTGeSXq8H7xfZ7A9tZkyNtsYsSc6KAk1TE12n9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MzRMCxrEdCfSJr+egFiRRoe3pwGPEZcD99zxZrYbt5ciHtwXGms9CUOlfLkUIsf3n
         Dq43lH7ZE8DC7AIwuA0rGofhxf6xABvBNbtWaHUv+oOCfnPeR0ROwg+1Ai+ZlgQb5I
         +8wPKWKn9HJIM/PdRtaqDctfJPytasl9aS/ekuyXlrcTDKEKwpxvBRAlPUIIKaD2D3
         NPRMXTl4LyGxzqCx4Dp97UM9fJe1HBjc+21snGc7Qxw54p9XORNR8EB+byaaoavD+E
         VVQpmcJF+uIuCzlRajzE5SxibJTalb1plXMeva9WeuOTsFJBk66cqpXDXkODEpG4zU
         zFmJFk59vKE8w==
Date:   Tue, 4 Apr 2023 16:37:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     djwong@kernel.org, dchinner@redhat.com, hch@infradead.org,
        linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
        rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 00/23] fs-verity support for XFS
Message-ID: <20230404233713.GF1893@sol.localdomain>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 04, 2023 at 04:52:56PM +0200, Andrey Albershteyn wrote:
> The patchset is tested with xfstests -g auto on xfs_1k, xfs_4k,
> xfs_1k_quota, and xfs_4k_quota. Haven't found any major failures.

Just to double check, did you verify that the tests in the "verity" group are
running, and were not skipped?

- Eric
