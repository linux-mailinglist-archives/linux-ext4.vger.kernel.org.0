Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54037BBE62
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Oct 2023 20:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjJFSGu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Oct 2023 14:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjJFSGp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Oct 2023 14:06:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FC6C2
        for <linux-ext4@vger.kernel.org>; Fri,  6 Oct 2023 11:06:44 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 396I6ZKA008091
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 14:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1696615597; bh=HK6IeKP0jWF8kC294G6zEBqKMUWq1VQhsQhaMg9FHGQ=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=X7ljnKWO5tRZGDYl/jQNBLhz08m5QxDzi0441T263o9oo8Cdc/W8BYThu2KVWN+Rm
         c9lIYFLfesAtG1uXZVwmDaaU8jv9LTq1SIK4iRv+Ys2/cuLC0DFdxkPNDBxqZrsMxQ
         QyB8fTmyJ8Mfms4PdgiG60if7S9xENsr82h135Pdc9qrNg2WK2FJmQfQ2RRMdEq8tS
         L9LtARksRiUTT94nDXDNDa2FhLa0/ZdtwZ+gsq+yNz4hjgD1y1AfUcENlNpFCQyqVR
         hQXsyW3DsTUIFAiI3d0iRdetBzgsC3BCrwv2yBlT4632Hunr5Ewx2zS6zJwF0cGITO
         HyCvXhNuiAuvw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 24D7415C0262; Fri,  6 Oct 2023 14:06:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Max Kellermann <max.kellermann@ionos.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, stable@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] fs/ext4/acl: apply umask if ACL support is disabled
Date:   Fri,  6 Oct 2023 14:06:22 -0400
Message-Id: <169661554698.173366.5671652974499380760.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230919081824.1096619-1-max.kellermann@ionos.com>
References: <20230919081824.1096619-1-max.kellermann@ionos.com>
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


On Tue, 19 Sep 2023 10:18:23 +0200, Max Kellermann wrote:
> The function ext4_init_acl() calls posix_acl_create() which is
> responsible for applying the umask.  But without
> CONFIG_EXT4_FS_POSIX_ACL, ext4_init_acl() is an empty inline function,
> and nobody applies the umask.
> 
> This fixes a bug which causes the umask to be ignored with O_TMPFILE
> on ext4:
> 
> [...]

Applied, thanks!

[1/1] fs/ext4/acl: apply umask if ACL support is disabled
      commit: 484fd6c1de13b336806a967908a927cc0356e312

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
