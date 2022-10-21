Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F64F607A3E
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Oct 2022 17:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJUPM5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Oct 2022 11:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJUPMn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Oct 2022 11:12:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829EB3054D
        for <linux-ext4@vger.kernel.org>; Fri, 21 Oct 2022 08:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ECB661ECA
        for <linux-ext4@vger.kernel.org>; Fri, 21 Oct 2022 15:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73072C433D6;
        Fri, 21 Oct 2022 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666365161;
        bh=8m2avfAXrTpkFgPE6E4Jl2Z3bu+4g0I8Ms9j0U5y+o0=;
        h=Date:To:From:Subject:From;
        b=IiInxpiMa+a+qssKqUrfx1xKZ8ZxL5lBl7BsjepbGgwSn5FGWJCx1bTjhga+9kKrE
         WCHMTsCQFrtkGioYW/TnW1ZJLC9yoRnVx06M+t3hCIlM0cRyv6NvPAxmhtssDQerCm
         APAy8SSeq7oIU2n2TiAhpmDLDkzolXKtrjFLieCQ=
Date:   Fri, 21 Oct 2022 08:12:40 -0700
To:     lkp@intel.com, akpm@linux-foundation.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 1/1] fs/ext4/super.c: remove unused `deprecated_msg'
Message-Id: <20221021151241.73072C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Subject: fs/ext4/super.c: remove unused `deprecated_msg'
Date: Fri Oct 21 08:05:49 AM PDT 2022

fs/ext4/super.c:1744:19: warning: 'deprecated_msg' defined but not used [-Wunused-const-variable=]

Reported-by: kernel test robot <lkp@intel.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/ext4/super.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/fs/ext4/super.c~fs-ext4-superc-remove-unused-deprecated_msg
+++ a/fs/ext4/super.c
@@ -1741,10 +1741,6 @@ static const struct fs_parameter_spec ex
 
 #define DEFAULT_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
 
-static const char deprecated_msg[] =
-	"Mount option \"%s\" will be removed by %s\n"
-	"Contact linux-ext4@vger.kernel.org if you think we should keep it.\n";
-
 #define MOPT_SET	0x0001
 #define MOPT_CLEAR	0x0002
 #define MOPT_NOSUPPORT	0x0004
_
