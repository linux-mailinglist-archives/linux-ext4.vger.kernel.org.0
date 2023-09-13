Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16DA79EBF2
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Sep 2023 17:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbjIMPCm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Sep 2023 11:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239071AbjIMPCm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Sep 2023 11:02:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4ADAF
        for <linux-ext4@vger.kernel.org>; Wed, 13 Sep 2023 08:02:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 413B9C433C7
        for <linux-ext4@vger.kernel.org>; Wed, 13 Sep 2023 15:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694617358;
        bh=RMld45cpOORWbn6ZTKuz54sPg19DeBkSe2jOqyOlf50=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ap3vsAs9Du2fxp/9sKBKlwVaAZnFPCj+htsrhNR0+TSXSQQdZy0wo0i3FNjHkboDR
         jAJ8xeDZix7HfkpObihPbP9RyeUAeCdzKAQcDYTH50OEMVPSKC822GOG28eSUX/D/r
         4Ozw2aKMMVN4AbQfbvyRcgUmoZTShbWDcQbZvRFJ8EEQosDBwaoQUlzHVMehkPMZQC
         0tqksmUrQoUp9QOAUvrjKX7TRmdYFqaSd4Gc88Tt80YMuRQtO77L4hQPZ9AEZsZYJh
         5b4xCCXgIdSGGHM6Qg+ZFu8sC4y/SiNwTYQh7HyZUsAtHD8WuPtLI/y9dINNx9CrkC
         OMsZS16f4r1wg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 292C5C53BCD; Wed, 13 Sep 2023 15:02:38 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1 tasks
 refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Date:   Wed, 13 Sep 2023 15:02:37 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jack@suse.cz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216322-13602-ieQ6qjWnwn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216322-13602@https.bugzilla.kernel.org/>
References: <bug-216322-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216322

--- Comment #14 from Jan Kara (jack@suse.cz) ---
Created attachment 305102
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305102&action=3Dedit
[PATCH 1/2] ext4: Move setting of trimmed bit into ext4_try_to_trim_range()

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
