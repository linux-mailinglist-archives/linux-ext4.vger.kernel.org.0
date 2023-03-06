Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93F86AC012
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Mar 2023 14:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjCFNAV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Mar 2023 08:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjCFNAP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Mar 2023 08:00:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A25829415
        for <linux-ext4@vger.kernel.org>; Mon,  6 Mar 2023 05:00:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6BAAB80DFE
        for <linux-ext4@vger.kernel.org>; Mon,  6 Mar 2023 13:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FA93C4339E
        for <linux-ext4@vger.kernel.org>; Mon,  6 Mar 2023 13:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678107609;
        bh=eB52U0dnNtY4DHTY2HxzCE7uuCaXKT0cF5StN/w6D0w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=irsfnC1cdAHHqwDhZh5fuKmmQNSBRa47hHW1qWuTStRrzsilD+6yzFBJiaqgzt7Bf
         RSo/QtAyBEHwXPCmdL3DaBwM1H3MEUpNOhu8SfDUNg6iLiNOxGtoaTwnPpVs0hl1jy
         KX8brL8h83PRZ7monb/qjnj52XYPbTmSeOpkDT+WFRXPrQHzJJsvfEwBmXI28LNDD1
         f6u9m97MkHNDb/GfbRQYWeSY516HplRnBkBntUmpLiIvIT8AdB3jB5/C57tmUypA6D
         QeVxrW4epYqfSUZFOpEGa62ijyOn239/JtFzqakO+Zbzcbtms70RRkubRayJpxRz7+
         XiIxE8OWUXQkQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 281DDC43144; Mon,  6 Mar 2023 13:00:09 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217145] Feature request: I need very long directory and file
 names
Date:   Mon, 06 Mar 2023 13:00:08 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: vyacheslav.sahno@yandex.ru
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217145-13602-ub4e2XQPaO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217145-13602@https.bugzilla.kernel.org/>
References: <bug-217145-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217145

--- Comment #2 from Vyacheslav Sakhno (vyacheslav.sahno@yandex.ru) ---
Directory name is a story of a filming day of 1-3KB length, video file name=
 is
a story in a video with a length also 1-3KB. I read them "diagonally" and i=
t is
a digest as a tweet but bigger.
https://yandex.ru/search/?text=3Dlinux+torrent+client+cutting+long+torrent+=
file+names&lr=3D10828&clid=3D2583699&win=3D567

https://askubuntu.com/questions/181730/how-to-download-torrents-with-long-f=
ilenames

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
