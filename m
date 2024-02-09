Return-Path: <linux-ext4+bounces-1182-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E318684F486
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Feb 2024 12:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82092B2A32C
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Feb 2024 11:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4FA2E652;
	Fri,  9 Feb 2024 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ScLg6ycF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nX05Qnqg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ScLg6ycF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nX05Qnqg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D752E84A
	for <linux-ext4@vger.kernel.org>; Fri,  9 Feb 2024 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477671; cv=none; b=P0nleSRuNlP8Y66VSOpnETsRueg19Gh0svpmVzjYVUWtA0gwJpVVv2V7kBa64nZub9MalKDBaff3OoZ1TO9tiIkijpbaiGIDUGGIkCshYYbpbHNbxxz/4DwwmrQfxHsKhUM9f0r5mV7T9AePkU7v0pQ2OKnV4HX87NgPa8KMphY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477671; c=relaxed/simple;
	bh=kkkrl6TbbDWN1p2zN/ySEtF7x54/GGpgvIUOu2I+3fM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p5y2nte8Nc3ELWICIRA93gOsYNpW6yyNiWHiAPIe4AWTgpVrYmmQtDFFGWM2ndGjJTpu9oapLEYDy28X9e/x9EH28o//Ss6k8SVtUseMcbZeQsArUcvPSKneIOSGzgExuP0O5WAakSd6EUohEg8zAXxXApDZAPVtL4jEwVZTp9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ScLg6ycF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nX05Qnqg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ScLg6ycF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nX05Qnqg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D68F41F803;
	Fri,  9 Feb 2024 11:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707477667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ircD6G08W42YsOAwaerWh9twZj91K6+3eLcVfarhVCQ=;
	b=ScLg6ycFKDjkUsj90niWGBD0bZL3sgGM0tcAm82Y/7BDPSUWkVwN0Hu3SxsgJZGdoADyDI
	2EM8pt87l/RbxEOQXWi0QLnj2XD62wyo09xBAsLHNFrgckIcGmJ5DbZH5Q7q10b/7OWyun
	SBSwivh9F0BwEq11N2gWvRvPHO93KFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707477667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ircD6G08W42YsOAwaerWh9twZj91K6+3eLcVfarhVCQ=;
	b=nX05QnqgG7AzvhOHqo9jonuhvl9Vp4ihE3xicj3QxTfzpx7HRbBkcQjsZFYaSiVixhZ5WT
	6b5wB886zwrywuDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707477667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ircD6G08W42YsOAwaerWh9twZj91K6+3eLcVfarhVCQ=;
	b=ScLg6ycFKDjkUsj90niWGBD0bZL3sgGM0tcAm82Y/7BDPSUWkVwN0Hu3SxsgJZGdoADyDI
	2EM8pt87l/RbxEOQXWi0QLnj2XD62wyo09xBAsLHNFrgckIcGmJ5DbZH5Q7q10b/7OWyun
	SBSwivh9F0BwEq11N2gWvRvPHO93KFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707477667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ircD6G08W42YsOAwaerWh9twZj91K6+3eLcVfarhVCQ=;
	b=nX05QnqgG7AzvhOHqo9jonuhvl9Vp4ihE3xicj3QxTfzpx7HRbBkcQjsZFYaSiVixhZ5WT
	6b5wB886zwrywuDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C71B313A2C;
	Fri,  9 Feb 2024 11:21:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UxlPMKMKxmWiNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 09 Feb 2024 11:21:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6A76AA0809; Fri,  9 Feb 2024 12:21:07 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] ext4: Create EA inodes outside of buffer lock
Date: Fri,  9 Feb 2024 12:20:58 +0100
Message-Id: <20240209111418.22308-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=554; i=jack@suse.cz; h=from:subject:message-id; bh=kkkrl6TbbDWN1p2zN/ySEtF7x54/GGpgvIUOu2I+3fM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlxgqU2Mw0ocgbmWlfhOxRCEY2BxwR5Jqje+Dcp6OW XykkPYmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZcYKlAAKCRCcnaoHP2RA2WHECA Dmkot3H58LqSVUfze9yD15rzfanNYzLEIOlqwFqhtwoN4eQAHgJY4t2CgfAwx1HeGPi2SZMscRFLKZ 0SUkOmgaa0qMGA3pa/78jJe6Z2as8kgjDTl4eLrfk6M266P+DQ4+gnvCnS4xQFJzVAt05YL5IUPfvJ xp3BuIoiOt4cKpAifEcYQI5+OoyGQGb8ozeBflPso99IKR4SCFdXr9ylKriE9KwdmDrkx5akcW8PrU jZhtBQ7q1uE5xgb9vPZBvUvQKaVz4UPqcQVxK99NLdq+qY2BILyNBiYsA9BBR3Ru/MIvnrREdX019t n6wRYYrlJ44VcKD2maT846UVPIAPSL
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[36.79%]
X-Spam-Flag: NO

Hello,

ext4_xattr_set_entry() creates new EA inodes while holding buffer lock on the
external xattr block. This is problematic as it nests all the allocation
locking (which acquires locks on other buffers) under the buffer lock. This can
even deadlock when the filesystem is corrupted and e.g. quota file is setup to
contain xattr block as data block as syzbot has spotted. This series moves
the allocation of EA inode to happen outside of the buffer lock which is
generally more sensible and also fixes the syzbot reproducer.

								Honza

