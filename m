Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C2E7BBE6A
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Oct 2023 20:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjJFSHX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Oct 2023 14:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjJFSHR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Oct 2023 14:07:17 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485A410F
        for <linux-ext4@vger.kernel.org>; Fri,  6 Oct 2023 11:06:55 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 396I6Za5008131
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 14:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1696615597; bh=mr075E0vbysKeosPdyKyyZ5tx2f+fvQsKsANHF81asw=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=HY2zQYSet9Mvn1UoYJQ6DtkO8AHtWyoaeRtQN/9OqJitJcrCmvT0Z45m7ugcgvEIa
         iZZtK6lowpCLRS82Y5zFARC92WdlceYVZzEhTsflOEhCOumRMI2bWq8tGiYW+nPBwX
         aQhzZd3KK1V5iLasfSVeUNeQruBmYD6nZf+xyMMlS3f3u+SXl0hG721ZiAQ6OZNNzV
         XsKkUMLIVRLNYsALccP/IjY59cv8j47Yo+eBbe+Lwr94wSAUzzqSZN4pOgnLsaMxmE
         iCR0LffgMH/MZztizcw/2Du9se9vwlYZ9wazCYJq3z/k76ORsD+xIBtHmLMGW1+h+9
         zrWahgkqcEt5A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2FA8815C0281; Fri,  6 Oct 2023 14:06:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH v2 0/2] JBD2: print io_block if check data block checksum failed when do recovery
Date:   Fri,  6 Oct 2023 14:06:28 -0400
Message-Id: <169661554698.173366.15345451852444153376.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230904105817.1728356-1-yebin10@huawei.com>
References: <20230904105817.1728356-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Mon, 04 Sep 2023 18:58:15 +0800, Ye Bin wrote:
> Diff v2 vs v1:
> Modify print information for the first patch according to Jan Kara's suggestion.
> 
> Ye Bin (2):
>   JBD2: print io_block if check data block checksum failed when do
>     recovery
>   JBD2: fix printk format type for 'io_block' in do_one_pass()
> 
> [...]

Applied, thanks!

[1/2] JBD2: print io_block if check data block checksum failed when do recovery
      commit: 71cd5a5aa0607073adba3852739b7f8c22bc7b50
[2/2] JBD2: fix printk format type for 'io_block' in do_one_pass()
      commit: 8b6b562121f1981315e76b6ae1f8a5cbbcf14bd7

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
