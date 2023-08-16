Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF2677D902
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 05:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241519AbjHPDXb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 23:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241598AbjHPDXa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 23:23:30 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E026E94
        for <linux-ext4@vger.kernel.org>; Tue, 15 Aug 2023 20:23:28 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-114-154.bstnma.fios.verizon.net [173.48.114.154])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37G3NILY011068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 23:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692156200; bh=LHBU+C50HbcjO5gX9YU6kdFHCs/ZCwk5dQLSRBu/HPg=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=kP2t128Ba7/yENhO7HfiKbCgK3Rf3BjqKO5LgJJFfvc0QHFzesH1ywQRda/AzMdAm
         0bZyN/sbKX0uEZyzO8iDvlz+AoXrmM87vkTiW+uA/oAhPgK4m5BQhFfIjvHdUFdUwe
         BbdUdRhZ6m13kXkyrL4G3YQBgAuHwYo8diuWHHhcYgV6uvaTgRfU5lAea1U28B8/6w
         I+5PNdkSf3/lWToN2MW29xTAIlqn+SjDTe20ZkEADyJ2Eq7882b3DPLwDMTKGqwk95
         JMOFMt9SS3vtC4w7/cqPdFomM8g3p5NjYt76sxKFH06H/TCApon6NjzAHsF6EVW7YS
         igP/LtsOWyT0g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C3C0D15C0292; Tue, 15 Aug 2023 23:23:18 -0400 (EDT)
Date:   Tue, 15 Aug 2023 23:23:18 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] ext4: remove EXT4FS_DEBUG defination in resize.c
Message-ID: <20230816032318.GQ2247938@mit.edu>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-10-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629120044.1261968-10-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 29, 2023 at 08:00:40PM +0800, Kemeng Shi wrote:
> Remove EXT4FS_DEBUG defination in resize.c for following reasons:
> 1. EXT4FS_DEBUG will enable debug messages, it should only be defined
> when debugging.
> 2. ext4.h included from ext4_jbd2.h after EXT4FS_DEBUG defination will
> "#undef EXT4FS_DEBUG", then EXT4FS_DEBUG defination in resize.c can't
> actually turn on ext4_debug messages.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
