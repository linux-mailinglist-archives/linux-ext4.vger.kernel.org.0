Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9445C77D93D
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 05:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbjHPDsF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 23:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241682AbjHPDrl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 23:47:41 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A672689
        for <linux-ext4@vger.kernel.org>; Tue, 15 Aug 2023 20:47:39 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-114-154.bstnma.fios.verizon.net [173.48.114.154])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37G3lUXt020958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 23:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692157652; bh=EuRGbxNOM6AB4uAEJSNky4ZCBYjzEQE6GET5vvFq+iI=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=ZvxTeciwf1cN5BXLEqBzGS7TeULnV7N0hT2vGn+dpg8ZbOZWkE+tuewzVS3VciGPS
         0xGAbyjA2gmWsOhprWchxpmDZVhu7Lr5PfbW2dFtiUvbT56q9V5P6gmUfuZ7zSkmqO
         UGQhyd/re9pz5tfjqSRKpc6I31iOLVgUZ7tGb2tMCUkedMmHhUIpH1xE0Qmkong+kK
         EpiknmSelavD+MzjCDRaUSMjja+ASz0FhxKM90eYb/Rk1mV/AwsM5JQ0ACroBGAp3M
         rNhMDuTKc8vI8zVTaI982+yIr9tyi1xXHhSwZxtUmv4qvIiiDp0RdTUZibYFmaWzdP
         MeUQLAU0REkYw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7F21B15C0292; Tue, 15 Aug 2023 23:47:30 -0400 (EDT)
Date:   Tue, 15 Aug 2023 23:47:30 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] ext4: remove unnecessary check for avoiding
 multiple update_backups in ext4_flex_group_add
Message-ID: <20230816034730.GT2247938@mit.edu>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-13-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629120044.1261968-13-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 29, 2023 at 08:00:43PM +0800, Kemeng Shi wrote:
> Commit 0acdb8876fead ("ext4: don't call update_backups() multiple times
> for the same bg") add check in ext4_flex_group_add to avoid call
> update_backups multiple times for block group descriptors in the same
> group descriptor block. However, we have already call update_backups in
> block step, so the added check is unnecessary.

I'm having trouble understaind this comit.  What do you mean by the
"block step" in the last paragraph?

					- Ted
