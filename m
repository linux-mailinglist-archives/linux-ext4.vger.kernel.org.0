Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8497D63CA38
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Nov 2022 22:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbiK2VM6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Nov 2022 16:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbiK2VMf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Nov 2022 16:12:35 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862FF2613F;
        Tue, 29 Nov 2022 13:12:26 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2ATLCJB3029725
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 16:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1669756342; bh=NVlHbOGEi8Vb8KhBrHaFFO2qVHyHoncNMDQIH/qVy3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WeygZ8mRKmR/BZl1HFfLPtC8TAlzOgRD6poOpU+FxNJG3N/pZC7LHmH5AXCSHKdRy
         u1lS0nyaNkkOqTyaKStBxZ1HPljxGhHgGWwDq6DbMyb3abL2qid2J0zw+yXer4x7b6
         XHnCXAa8xsB0nyi1Ojc8VEV76shaXFtR2LSdkMq1uA48KtF+7TMHWPqxnwpCGKbtz9
         Cs9gla2hqoj5eFOEFdJHEwF4cUgEA1kOu7MnGnJGcyu0TqUA0eeLK/qC9F73mxW1B/
         MfGoG2A/+DFGe8GvFzrDwCUBixvyIhJBUt6VwLmRTQdzx6iWgLS2VzmtUqb9eENSx2
         2S2i22mD/vJZA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6089F15C33A3; Tue, 29 Nov 2022 16:12:19 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, cgel.zte@gmail.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Zeal Robot <zealci@zte.com.cn>,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] ext4: remove redundant variable err
Date:   Tue, 29 Nov 2022 16:12:08 -0500
Message-Id: <166975630694.2135297.2012560761216348231.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220831160843.305836-1-cui.jinpeng2@zte.com.cn>
References: <20220831160843.305836-1-cui.jinpeng2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 31 Aug 2022 16:08:43 +0000, cgel.zte@gmail.com wrote:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> 
> Return value directly from ext4_group_extend_no_check()
> instead of getting value from redundant variable err.
> 
> 

Applied, thanks!

[1/1] ext4: remove redundant variable err
      commit: eb46ec409d2d9f2ea72af29428ad3dad754a7362

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
