Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D62F64586C
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 12:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiLGLAH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 06:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLGK7f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 05:59:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A70027168
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 02:59:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBEC261488
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 10:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D3BCC4347C
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 10:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670410767;
        bh=vbdXVzPZjpUxZM8MMFjjKYAp4J+jGWfJVBRXqbrMaNc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZoMIjCrNqSSnJ0xuHaenzpymSgoQ8PxTzbpCe1lE+ImNSc9U/IiRcju+7FGCpT3Kj
         kzQO/m29BYaCPAqIYPq+SrVx3nNvDTkvgEPcdhsOlwSbh7HDvH/WaGlQDBpk/O1gZz
         I8gAaxYajhi0k5yv/WwxcxyJKtlRa/f4eC3HSqZh5GYKAG2WH6XNXpEmWf5+5smY1O
         fIqxQqRCwpZTFzi9GpD7oa+Do9tdD6q158MNIrmp2t7Bot7O6XQAqHONiLT9YvoC4r
         stunzzVKipkVrsiO4QurxY49Ek/ssKMXb0MOiL7M9il0V1QzBBqQJC3zwVwxZGbrdC
         NA2XG5u6bCnJg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 49936C433E4; Wed,  7 Dec 2022 10:59:27 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216783] There is "ext4_xattr_block_set" WARNING in v6.1-rc8
 guest kernel
Date:   Wed, 07 Dec 2022 10:59:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pengfei.xu@intel.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216783-13602-LnJYBnKrDk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216783-13602@https.bugzilla.kernel.org/>
References: <bug-216783-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216783

--- Comment #1 from xupengfe (pengfei.xu@intel.com) ---
Sorry, I created this ticket with problem, and I created the ticket with a =
new
one:https://bugzilla.kernel.org/show_bug.cgi?id=3D216784

So please ignore this one, and use the abovel link to track.

Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
