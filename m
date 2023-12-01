Return-Path: <linux-ext4+bounces-260-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F9A800DA2
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Dec 2023 15:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCB9281B75
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Dec 2023 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CAB3C6BC;
	Fri,  1 Dec 2023 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GhPhqXoz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB8710F9
	for <linux-ext4@vger.kernel.org>; Fri,  1 Dec 2023 06:47:05 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-111-98.bstnma.fios.verizon.net [173.48.111.98])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3B1Ekv8i005614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Dec 2023 09:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1701442019; bh=PUwZlceDVLEqxoUTul3C7ObFnLoncs9F+0NCN18mqAM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
	b=GhPhqXozzanxriG+2wXljZlg/iQO0kyjS2aCCfFjZGzyDcl91Z9PjSn3Mu5HnMF7g
	 mU6DhPekLMnyQB3YFB1DZcHsQmonQyk4KvJdRxpIRanf2u1LHbWsrJdsyr7zFjVWM2
	 DpcVUx5vT4QJtBG7lDJSsKl1MnCEGWcRUCPnPb1khj0dbN3uGyX4rFUPL6/Ucnojh1
	 NlbRhGZuAGSRuHpzVo3ZhewGhF0M8sFeyK8PVhDybHufiKyVhwn0qC0d0zRXoadULG
	 nIP0hESVbF4Lb071A0o7zY4V4VnBPsOk7xtdGIU864fZkUJSC+boXlK/40hTi9bB9v
	 BcP7K27aWoNHA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 5D25115C027C; Fri,  1 Dec 2023 09:46:57 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>,
        syzbot+47479b71cdfc78f56d30@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ext4: Fix warning in ext4_dio_write_end_io()
Date: Fri,  1 Dec 2023 09:46:54 -0500
Message-Id: <170144199127.633830.5706636957999053594.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231130095653.22679-1-jack@suse.cz>
References: <20231130095653.22679-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 30 Nov 2023 10:56:53 +0100, Jan Kara wrote:
> The syzbot has reported that it can hit the warning in
> ext4_dio_write_end_io() because i_size < i_disksize. Indeed the
> reproducer creates a race between DIO IO completion and truncate
> expanding the file and thus ext4_dio_write_end_io() sees an inconsistent
> inode state where i_disksize is already updated but i_size is not
> updated yet. Since we are careful when setting up DIO write and consider
> it extending (and thus performing the IO synchronously with i_rwsem held
> exclusively) whenever it goes past either of i_size or i_disksize, we
> can use the same test during IO completion without risking entering
> ext4_handle_inode_extension() without i_rwsem held. This way we make it
> obvious both i_size and i_disksize are large enough when we report DIO
> completion without relying on unreliable WARN_ON.
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix warning in ext4_dio_write_end_io()
      commit: 619f75dae2cf117b1d07f27b046b9ffb071c4685

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

