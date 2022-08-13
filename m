Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8868B591B30
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Aug 2022 16:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbiHMO6V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 Aug 2022 10:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbiHMO6U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 Aug 2022 10:58:20 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31667DF31
        for <linux-ext4@vger.kernel.org>; Sat, 13 Aug 2022 07:58:19 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-49-209-117.bstnma.fios.verizon.net [108.49.209.117])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 27DEwC6T022503
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Aug 2022 10:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1660402694; bh=HX/FeSKCOcU+RjYo8yYzDCS9E2Jy0USLrdmqXumhOqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gJjeUXefLBRQS/CAonX5+UnyfeknK92kzXAmLm/x0rD9Y0Xk8pXgvvTOlNcQlAS8z
         1pztucVEHp0TKG2/0yYiCfvmtH8fuGXzNhc75IAjFCOBaFzZeJucsTWrCMgJgY/GBe
         X0g6wAd8OKuAlY66klfNt+JchQuBuHdM6vTyRRvnf5GScZ9KQdlY0Zyb1DpHigvoMj
         PfjEndPxJAErmDx0DRxjiA1JXZypWqVt93Benh+Eji28E6xDSjIQKmPxIANq9jI0HO
         eC9vCmrBMN/S9MQAoVbmOqvJJmUCiOMlOnc3A9uvhMK+B4bc/+bPJrmW6l9CZvo0SS
         By/seeT/Mi1qw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B113915C00E4; Sat, 13 Aug 2022 10:58:12 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, lczerner@redhat.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, danielng@google.com
Subject: Re: [PATCH v2] [PATCH] e2fsprogs: fix device name parsing to resolve names containing '='
Date:   Sat, 13 Aug 2022 10:58:09 -0400
Message-Id: <166040264336.3360334.4832672954892451811.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220812130122.69468-1-lczerner@redhat.com>
References: <20220805094703.155967-1-lczerner@redhat.com> <20220812130122.69468-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 12 Aug 2022 15:01:22 +0200, Lukas Czerner wrote:
> Currently in varisous e2fsprogs tools, most notably tune2fs and e2fsck
> we will get the device name by passing the user provided string into
> blkid_get_devname(). This library function however is primarily intended
> for parsing "NAME=value" tokens. It will return the device matching the
> specified token, NULL if nothing is found, or copy of the string if it's
> not in "NAME=value" format.
> 
> [...]

Applied, thanks!

[1/1] e2fsprogs: fix device name parsing to resolve names containing '='
      commit: 18ebcf26f478702cd09dd4229320d449469f1490

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
