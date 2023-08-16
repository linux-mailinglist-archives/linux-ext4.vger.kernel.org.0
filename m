Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C808B77D904
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 05:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbjHPDYe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 23:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241597AbjHPDYO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 23:24:14 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F569213A
        for <linux-ext4@vger.kernel.org>; Tue, 15 Aug 2023 20:24:13 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-114-154.bstnma.fios.verizon.net [173.48.114.154])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37G3O1cl011395
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 23:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692156242; bh=aNiMBAvSNhPAwfKYRAlurN56hZ4CZGQTSs3pCySVrQg=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=KzwnXzbMw+YVRAMCrB0R+pm3u28MVrrX+XpnVuQUole0khDifSO2m0+ZIVx9OvelN
         75RGGEudeCUwNVifpLqUi8EJoa6bQ/JMAyAck3Knc4W1eJKxqtPUYJ5xW5HO5x/VgD
         dFRD9XKj1c4SIgV6EqUeKBKX5y+jNLhOAQFUESe6JahRIyJW0McQJelR5/2ebOm4q/
         HbRI/boFquNet4Xi2pMvelNSukfxj5tlLzlKcKR3LpDzW+YhG11INqDR9HC62PEjyp
         EeuQ6/lWtumM0k98nlYYuDd8q+///0jGHxNGc0MRBhY5V3KVbHyWolAxtTZyhpzBOG
         gbTLFPnDLSzYQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1B37F15C0292; Tue, 15 Aug 2023 23:24:01 -0400 (EDT)
Date:   Tue, 15 Aug 2023 23:24:01 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] ext4: use saved local variable sbi instead of
 EXT4_SB(sb)
Message-ID: <20230816032401.GR2247938@mit.edu>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-11-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629120044.1261968-11-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 29, 2023 at 08:00:41PM +0800, Kemeng Shi wrote:
> We save EXT4_SB(sb) to local variable sbi at beginning of function
> ext4_resize_begin. Use sbi directly instead of EXT4_SB(sb) to
> remove unnecessary pointer dereference.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
