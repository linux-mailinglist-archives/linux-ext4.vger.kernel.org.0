Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C874D7525B2
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jul 2023 16:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjGMOz0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Jul 2023 10:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjGMOzZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Jul 2023 10:55:25 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E69E2719
        for <linux-ext4@vger.kernel.org>; Thu, 13 Jul 2023 07:55:16 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-193.bstnma.fios.verizon.net [173.48.82.193])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36DEtB0q026882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 10:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1689260112; bh=eYuaEagulq7Vxq4xssHucTWaWl34VzjA4qgAICEF4yg=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=OdRNzaG+VPuPZ661uvfM+K7p7v7pzSZ8mbO6uiidjRb0QOIDN7hdsKlxxTcspLWbp
         F+si+o67PsImwu5ImSuixOediOwdLht0vPgb5+z/5Jdxf1jh+cT+/KTyRX2dpfOv5v
         XXnLnCL/2vt7KzzuRHaK+9yEgBwKP5f6yQqm7fLGa8+41EtuC6g0lbxmH1Eh3/W/oB
         7bxjFTKEWF00zr6Mf2kQF17Qyp4YhDIhS5JahmdUZK/0RZQA+LOmplP3vNqmPIVvKe
         JO41M2hVgb9GstS4AUzWp1zT05kBeJ9nyMHf8r2WP8B8DG6ebNpYjNa6T6itKj7/KG
         Y+HWFrS7OqeHg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 00F6A15C0280; Thu, 13 Jul 2023 10:55:10 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] ext4: correct inline offset when handling xattrs in inode body
Date:   Thu, 13 Jul 2023 10:55:06 -0400
Message-Id: <168926009829.3728471.16954986792300189725.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230522181520.1570360-1-enwlinux@gmail.com>
References: <20230522181520.1570360-1-enwlinux@gmail.com>
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


On Mon, 22 May 2023 14:15:20 -0400, Eric Whitney wrote:
> When run on a file system where the inline_data feature has been
> enabled, xfstests generic/269, generic/270, and generic/476 cause ext4
> to emit error messages indicating that inline directory entries are
> corrupted.  This occurs because the inline offset used to locate
> inline directory entries in the inode body is not updated when an
> xattr in that shared region is deleted and the region is shifted in
> memory to recover the space it occupied.  If the deleted xattr precedes
> the system.data attribute, which points to the inline directory entries,
> that attribute will be moved further up in the region.  The inline
> offset continues to point to whatever is located in system.data's former
> location, with unfortunate effects when used to access directory entries
> or (presumably) inline data in the inode body.
> 
> [...]

Applied, thanks!

[1/1] ext4: correct inline offset when handling xattrs in inode body
      commit: 48ef88508c16866ec9641fdda38642aa1f776fd4

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
