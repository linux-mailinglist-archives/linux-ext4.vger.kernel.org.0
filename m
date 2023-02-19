Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57C869BE9E
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Feb 2023 06:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBSFlN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Feb 2023 00:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBSFlL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Feb 2023 00:41:11 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1641B13519
        for <linux-ext4@vger.kernel.org>; Sat, 18 Feb 2023 21:41:02 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31J5ethh024830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 00:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1676785258; bh=eJgUBz6eLTmywe3XVJOeIEccMrKWQI8lyLcxYit3y9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=i8W2GA01D5r9VpA2MB/MgObcjZtViyDN7QJGfSFGcUoHmhIMlRbZP9sVAdqSmJF/Q
         3yCORHszOhzjBP118rV9ak2KDpBXkMXD3AHk0Q8tAbUEHQW89et4CIvicPJ9OiTxOH
         P39rOBdrRg7gId6zISD5d0FZXun6ipT7sY6Hrhc/krvoZxBmCMnXvltIIITGPUnV7e
         1SfeuaaJl8gHn9EOCc9UXOUDtRT6k4Ri6Hl/38CWe/UDKpBSh4iH/feOhEOfH9lG9y
         ZU8/H6rOrzwOOPMj+TH00bwG2gOnrWiZFJX9lcwGAaKMhJDB/PrsLHFSb9gzURhoXg
         nxmbkg8DurgwA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C05B215C35A2; Sun, 19 Feb 2023 00:40:55 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Tanmay Bhushan <007047221b@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] ext4: remove dead code in updating backup sb
Date:   Sun, 19 Feb 2023 00:40:42 -0500
Message-Id: <167678522161.2723470.6209997833423278181.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221230141858.3828-1-007047221b@gmail.com>
References: <20221230141858.3828-1-007047221b@gmail.com>
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

On Fri, 30 Dec 2022 15:18:58 +0100, Tanmay Bhushan wrote:
> ext4_update_backup_sb checks for err having some value
> after unlocking buffer. But err has not been updated
> till that point in any code which will lead execution
> of the code in question.
> 
> 

Applied, thanks!

[1/1] ext4: remove dead code in updating backup sb
      commit: 08abd0466ec9113908e674d042ec2a36dfc2875c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
