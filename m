Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9503C591B31
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Aug 2022 16:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbiHMO6h (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 Aug 2022 10:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbiHMO6g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 Aug 2022 10:58:36 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB074DF31
        for <linux-ext4@vger.kernel.org>; Sat, 13 Aug 2022 07:58:34 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-49-209-117.bstnma.fios.verizon.net [108.49.209.117])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 27DEwCuG022513
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Aug 2022 10:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1660402694; bh=a3LtfiqjhVqgMm+5UWJjOu2/zDNiq1lmhzQ1ZijBsn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=g6KJR9FaXP/RNl9PG1AoUrpQ70tQYk07P//Ugnb8I6ekq7/UiibkEgSCy65u/tVtB
         eFfNaKeH+fUmRL8H8bdKdieL0Fo18OJYqYVV3wiWFwsJAmAAfV0ZAbEU9sxoV1ilG+
         dee2nrUaL1w0kBS8lUcLdx1FMjyrOPx68L7Xq5uAsgZkChpl/fmXwnc+vjMYqhu3IB
         mU6zM0xgWN95uPGAjwgqQFSnQd8f3A+ia4CRCgMGEQ16Qij1ztxgjZjklUei3BGD+5
         3Ua0BlChc58MsXD4VDl6nfaOmAeE4AjWKK7T0j5112rkqJuOagwJfwyhMqDrYq5lld
         k0DxifjBSKbcg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B3E7315C41BD; Sat, 13 Aug 2022 10:58:12 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     slava@bacher09.org, krisman@collabora.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        ebiggers@kernel.org
Subject: Re: [PATCH v4] tune2fs: allow disabling casefold feature
Date:   Sat, 13 Aug 2022 10:58:11 -0400
Message-Id: <166040264335.3360334.2890041357454607493.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220708122658.17907-1-slava@bacher09.org>
References: <87pmig39yb.fsf@collabora.com> <20220708122658.17907-1-slava@bacher09.org>
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

On Fri, 8 Jul 2022 15:26:58 +0300, Slava Bacherikov wrote:
> Casefold can be safely disabled if there are no directories with +F
> attribute ( EXT4_CASEFOLD_FL ). This checks all inodes for that flag and in
> case there isn't any, it disables casefold FS feature. When FS has
> directories with +F attributes, user could convert these directories,
> probably by mounting FS and executing some script or by doing it
> manually. Afterwards, it would be possible to disable casefold FS flag
> via tune2fs.
> 
> [...]

Applied, thanks!

[1/1] tune2fs: allow disabling casefold feature
      commit: 47f9c3c00bbfdef4a64f400d1c95d9140aab3199

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
