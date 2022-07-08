Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B97556B104
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jul 2022 05:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbiGHDUI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jul 2022 23:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbiGHDUH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jul 2022 23:20:07 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F215370E59
        for <linux-ext4@vger.kernel.org>; Thu,  7 Jul 2022 20:20:05 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2683Jxt9032633
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Jul 2022 23:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657250401; bh=9XroLkJofV17cl0O1PtolKLNVgwWAyB+/Ea+YPcfITA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pxu4N7cBJ+awDrN8cMVsAguNRwgh1hUyd7p3aZXvpmzsi5tc0ivi63BSpTky/s2Wl
         xKSgf8bzkeffl3o4bT1zmtqWRdQyUHcXqqrDxcRv0oDE1pbm1WWt21MeV0Qxcln76I
         XeJ4NDe74en5uuW4vSeMbNDv8hN66kUycx+RPG9TRKyuf1gtIIFYb4eMviImSOtt39
         JAg+hkm6T1KpcWzjsb6y4blIS+d/f177dBD8eLylko6TsG3X3RQLAQJbgBGEtawWrz
         LtjP0kVqNm/2cKlYm8c63SNY9YLqmHhld6kboNeTOta4O36OiV0Uenqv5zfTFyZkRn
         YCoaZG9CBUFsA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8967A15C4340; Thu,  7 Jul 2022 23:19:59 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     jack@suse.cz
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/4] ext4: Debug message and export cleanups
Date:   Thu,  7 Jul 2022 23:19:55 -0400
Message-Id: <165725003055.1812964.17030118227888208574.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220608112041.29097-1-jack@suse.cz>
References: <20220608112041.29097-1-jack@suse.cz>
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

On Wed, 8 Jun 2022 13:23:46 +0200, Jan Kara wrote:
> this series cleans up couple of things around debug messages in ext4/jbd2
> and removes some unnecessary exports.
> 
> Honza
> 

Applied, thanks!

[1/4] ext4: use ext4_debug() instead of jbd_debug()
      commit: d7acf6d8c57a29bb33eac2fe9b5af5a89053eee2
[2/4] jbd2: rename jbd_debug() to jbd2_debug()
      commit: f237450c7436c18446e6fc20c9da50825c1cb382
[3/4] jbd2: remove unused exports for jbd2 debugging
      commit: c56ed6eec06d47932d296a3ba64d0e4dca6bb5d4
[4/4] jbd2: unexport jbd2_log_start_commit()
      commit: 6c8bc8dd6d827d8bc0ddf85ac7da311a7a7faed0

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
