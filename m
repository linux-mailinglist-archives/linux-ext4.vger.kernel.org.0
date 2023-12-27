Return-Path: <linux-ext4+bounces-574-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8BB81ED24
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Dec 2023 09:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260CC1C22386
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Dec 2023 08:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A607F6130;
	Wed, 27 Dec 2023 08:08:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from 3.mo548.mail-out.ovh.net (3.mo548.mail-out.ovh.net [188.165.32.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161745691
	for <linux-ext4@vger.kernel.org>; Wed, 27 Dec 2023 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jwilk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jwilk.net
Received: from mxplan6.mail.ovh.net (unknown [10.109.148.105])
	by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 1E92E21BA0;
	Wed, 27 Dec 2023 08:08:09 +0000 (UTC)
Received: from jwilk.net (37.59.142.109) by DAG4EX1.mxp6.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Dec
 2023 09:08:08 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-109S003aa4fe78f-52c8-4118-b4d1-4aac9c4ba675,
                    231B90D979EBADA22E40B8F657CF839B9F6AD920) smtp.auth=jwilk@jwilk.net
X-OVh-ClientIp: 5.172.255.4
From: Jakub Wilk <jwilk@jwilk.net>
To: Theodore Ts'o <tytso@mit.edu>
CC: <linux-ext4@vger.kernel.org>
Subject: [PATCH e2fsprogs] e4crypt: fix spurious "Success" error message
Date: Wed, 27 Dec 2023 09:08:05 +0100
Message-ID: <20231227080805.6801-1-jwilk@jwilk.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DAG8EX2.mxp6.local (172.16.2.72) To DAG4EX1.mxp6.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 38ce9fab-9262-480f-8490-f078da0665bb
X-Ovh-Tracer-Id: 15809886493928249242
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvddvkedgudduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgggfgtihesthekredtredttdenucfhrhhomheplfgrkhhusgcuhghilhhkuceojhifihhlkhesjhifihhlkhdrnhgvtheqnecuggftrfgrthhtvghrnhepfefhteffhfffheetudefvdefheffgfduleejheeiteeihfefffejveeljeevheeinecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdelpdehrddujedvrddvheehrdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhifihhlkhesjhifihhlkhdrnhgvtheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdplhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehgeekpdhmohguvgepshhmthhpohhuth

Before:

    # e4crypt set_policy 0000000000000000 /dev/null
    /dev/null is not a directory
    /dev/null: Success

After:

    # e4crypt set_policy 0000000000000000 /dev/null
    /dev/null: Not a directory

Signed-off-by: Jakub Wilk <jwilk@jwilk.net>
---
 misc/e4crypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/e4crypt.c b/misc/e4crypt.c
index 67d25d88..af907041 100644
--- a/misc/e4crypt.c
+++ b/misc/e4crypt.c
@@ -144,7 +144,7 @@ static void validate_paths(int argc, char *argv[], int path_start_index)
 		if (ret < 0)
 			goto invalid;
 		if (!S_ISDIR(st.st_mode)) {
-			fprintf(stderr, "%s is not a directory\n", argv[x]);
+			errno = ENOTDIR;
 			goto invalid;
 		}
 	}
-- 
2.39.2


