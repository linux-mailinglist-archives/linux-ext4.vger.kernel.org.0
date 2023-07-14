Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DCC752E8A
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Jul 2023 03:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjGNBag (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Jul 2023 21:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjGNBaf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Jul 2023 21:30:35 -0400
X-Greylist: delayed 1813 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Jul 2023 18:30:26 PDT
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98872D78
        for <linux-ext4@vger.kernel.org>; Thu, 13 Jul 2023 18:30:26 -0700 (PDT)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49]) by mx-outbound21-247.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 14 Jul 2023 01:30:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERKdF3/oUwTxykG2vF+iR3eu3Cb2QNenQFbbkE0T3ZdHRh5lJm7q5dXqQ+NkS5wKYEkNuNzh4BkSXcAWgI1E9ujo6On/feNC7hTpJvGgvRIaC/g2LUGgWL+DH0+5ZcxLsELfMBSUyOclTNPmZh2sXZ5m48V7kiIukWDTn83BtIfMrhjA+DBrE3pYv6mctBAOmfhc5AUhNXlH9zPTchc/BMOVLpQxy1Yhia1o5ZxoWsRaWhUf6kPYy8PeyVTefiWrxGpvOnV2da3464wPNML3se2JUdZETJ10M+nK2R5i1WGAz9J8To9oFTNC9IaLXO9egggiaigaLD49DzkrpP0OcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43rjBWvn8RqsUQ4SHeypx8zHTBNMiKZKA4IeG3woFGs=;
 b=EP5g/r13lwp5DYLYWe0idPkTweKCyJJm/ZCAqPB/9n3MA/WQWPbnIA+phYKf7OnfIXilqpdqrqgqK0XcLK29S8v2oME7QHzHgxJ2xfLH1gi+Vxerbsqvd3+SCtu/igXdLK3YM3F7jLFsdY8trfFe3QOwTIqEYeaehO421nxg3Fwv07GV5SIaLLjloi2/ml3BCKomfiQ10ZVDDe2oJ7+s701PwAYwUTizZ4ZOESg77Z9aqhNph0dFzSAKewlK9DFSM1WtHstmanrypIPCkgac3DFXwpWtrzBorD52TCyqq8WMqBlC1WBUhlZGYn3kVaGK+yf0tv59S/mIiWfL5kI3YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43rjBWvn8RqsUQ4SHeypx8zHTBNMiKZKA4IeG3woFGs=;
 b=Min5S6uOT7wQh4+BwcDlfPFkxQibDOJJVu+pu5mG3kKZD6Km5LeeyIc0N2ekA0B4sdSliR6QLdQL/BAw8XG3zSaTw4r2ckDii1M0cJxRFGZtdlVwBOPBzq5M6ol7/XokWHdDhpbrTS2PfNFFyWJyB5hxSUp0h3xx6x+fTvxXNzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 MN2PR19MB4062.namprd19.prod.outlook.com (2603:10b6:208:1e4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 01:00:06 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::168a:ce63:a6c1:6bd5]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::168a:ce63:a6c1:6bd5%7]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 01:00:06 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger@dilger.ca, emoly@whamcloud.com
Subject: [PATCH] e2image: correct group descriptors size in ext2fs_image_super_read()
Date:   Fri, 14 Jul 2023 10:59:58 +1000
Message-ID: <20230714005958.442487-1-dongyangli@ddn.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0034.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::21) To DS7PR19MB5711.namprd19.prod.outlook.com
 (2603:10b6:8:72::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB5711:EE_|MN2PR19MB4062:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b9eeb9-a949-4976-800d-08db8405a9fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xnykowmkS0FUK5PonFdXVrZHn8wDOZE5QOXubnglN/Yzl/xw8df+3y1YDS74rJuk3XYcgGoNoaOTshkhwWDQOALphWwcXY6N161OuSjNd6eb2KCyMddnH+qQegnmuH2ZxGB2iWr15yJJHhlIN5IIuivKfr9tk5YnOVU0MvFFM8+TwEA35zFwZwRAj2W40LTPZX5u9BsgsfAiiDJf9+fCr9Apsvv3jLVIJggJcd1AaUMKhTeBza1/KSgEea81tSWtrv4AiGCE4/d+gaBN3WPR7WaJCnbfoac0aio4I+Maxw8/wsyP+KuMMh3MQNDYWr9254nbH/ZmNCri0bIZMdkFkFexUOUBZZLWXmKll6fLfVFv2Hlx21gwQude/ZrwyHTS4sCRSDrMN7quROG1U1oNso1uHUFUyHZzg+w7Mc5yZ98bl5BknGy7sRu+dBdGeZCDKIjEWP5qN4YuJQdhxg1IkLlB7ysjq+Zy0O7C/RwxyTbEhGQM/VJy8mvxyJqbbJyyzA1h+394hc+95WFfh0CH938U1WUgTxiWwFk+WDY0yiHCuPYc0qyQXNz4gPHqpXa4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(366004)(136003)(346002)(376002)(396003)(451199021)(6512007)(6486002)(6666004)(83380400001)(186003)(2616005)(36756003)(38100700002)(1076003)(26005)(55236004)(6506007)(107886003)(66476007)(66946007)(66556008)(6916009)(4326008)(41300700001)(5660300002)(316002)(8676002)(8936002)(2906002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ayrlLFC2DrSgSDPVS0qWwW2+Q5YTMLftaPIZlgEMS9drMxnshjCAPGbn7UaE?=
 =?us-ascii?Q?Cc26wr+OjoeILNQ5JJdlkCHE4s/9ayUDKGXQWYqvMmFrD21gh/66qerrZKMX?=
 =?us-ascii?Q?vRKFyOoDWUxtPMoe6Amb4OwnCZNN/ihzSyuekqurP3UrYTSqtP+8Pq3B8EGt?=
 =?us-ascii?Q?v3wAcP5FYbMNio2sON730andfVCj6ez4pPoAnbDEJZsRGYhWbL1B5U21n5ep?=
 =?us-ascii?Q?oYq8V8zY9lNYcYLUOMTCorISMF4nhDHN1GJnMwk0ndUaiAOFFApNOLCY+U9i?=
 =?us-ascii?Q?9Ey9k6GUSA+W0wK12KtPF7eMA5ap2HiYVmJURqaexBkHZq3wuqtNYC5lQYZS?=
 =?us-ascii?Q?UNuFoklfK75odZZBqFDQ11Dm2u3ld+CmYf6Lf8tqyLYbxCoqLtcnYkZB4s9v?=
 =?us-ascii?Q?49CaRrftF5cNOp39NTFfO3yxYYMKfYfZ8WRhUKo9WNhRxzY/s1T2DifOcHZZ?=
 =?us-ascii?Q?u5Aw1HatnyS4QY/jVYqtAKWtyCNZeHdhXHIP9VNjHQj1SifNnq1uo/BZATce?=
 =?us-ascii?Q?kQIRZI8o5sBhW+q/bmBkeJNUZ05hNsISLMb3qBfGPi3SgxYJJTxwsiD+XnWh?=
 =?us-ascii?Q?eLfByijTWQOPY0ELGzP9gTWlE34F/I33qBiOYO6NE24+z8POUZ/gCRd60Lu/?=
 =?us-ascii?Q?cmyZ/STs6CM4QDdDcptsJRNa//DbsYJkwmhzt97zD5yhiUghEY1Jm6ZwfFXk?=
 =?us-ascii?Q?xwxtLmTDYReO6kd02e45BzL8agc6QDVWMRzMexTGudzcCukKepzrJXj1IRgQ?=
 =?us-ascii?Q?BY1Z2pAKNWt00feFjz34mpuG03XlrqXeGgwvIMFUtP32/6CgOonzEfgFNBn/?=
 =?us-ascii?Q?ai8RG/LvkEQn/iz7sutboz2FkKFBodMWVyUXf6rPK1hEPMg+wXpKSzAswR6q?=
 =?us-ascii?Q?4lhrVxcIg7Sxho6aeKyqU8A7yC2Vd9PVJdy7ueGEhAP7qxmWexutp8hdSNuC?=
 =?us-ascii?Q?qyZH32wmZ/g4c8AoeWTFK01NF1+Vtm8v0/wY2aU4DSxMw4gb+uoAejnvGnK5?=
 =?us-ascii?Q?v5lRdxEsFn4M5NRKEIZRgfyelboRN3NFOkA4HMrJPE2SaF0okKuI0Kka2nZ7?=
 =?us-ascii?Q?/qM76knlHsrwpwCsSVJb8CkQq/+ZFEjp5OHON3fcnGwFXCuJdXzS47rZZ3v1?=
 =?us-ascii?Q?q4A6FQFef+VY7CxJz53BvgfxKEFe0SnL4jUVIYAwXPW0b6TlCIVzUIa3tRJc?=
 =?us-ascii?Q?pY4dWikR2wsBPd/+DIql6paWQA4gXqZLcwZ0e275YKKAWWexs32mg1bCja0O?=
 =?us-ascii?Q?KDLkPq2nB7VXvFXKIe8Eka2J/PS1uPkyo/CyXBbjb/vvD0IROl/MXHmucfe9?=
 =?us-ascii?Q?SgcuDaL8+6hhl0ipssXq3KtPzQCTd7WwkxCN8al0qi9LFNrLVi/xFflBU4hp?=
 =?us-ascii?Q?u0sG+13c+oREwOgiKc7ZVSLg1bFywgCaGL6pgqJzUHwk6OAzBEFYGmqt1oGo?=
 =?us-ascii?Q?BhbqxUDF+v6eB2aBORXSkq0mifu9I6gibB0C+yGMz1YHZsh+U3tSXo78bgMz?=
 =?us-ascii?Q?NukxqsQ0H744gFHZlUB5CaTPWR1fByuyTksd7HlCNWWxdMETaQHJ2Saofh3k?=
 =?us-ascii?Q?2F8X2KzuEYyCASs6boM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 30v3EcXck0j9x//avc7DxDfjf0zuEdwvS9ona1qtuVglVh/Wz+WivdAuLRdlQO7QXJNtYL8xtAJnn4v965tubYM8/cHusJc1rErrYSP0BOKxR8VoHY682dB3w+sk1gl8UqmtY6PWqt0nnh/LIgUDQefbrVqpVBJwokRy2LzwnXBHFIzUtoFXDGu8UgRwyHfraAANafVEJuOM2tzX8cUDIeyJlf2QgIePSq/bxNkGqxvnWeESDYuuLFXmz0FfHZNY4MwyZoIZ70DQoImegvIHftmRu8wqettD6zntI7GQEWDTk1tLdPHO8C6yJGu2M/YBrS9Hga1f492sDGTgpKbVRz1dUzafE/T66G6R4zfc0NZaBG/F+KYhfTtU+yW6IWIRAS2POLrE3qYYwlIMBBsVnO31NWW9MxYBKUrgcEleLrYtzDdqSoulDvS6y24pxajjPPbeMueUvBjUTOzdP1+SHrEWvaBW39vK1euNRoaCpDVMEetvDp5/EwjjquP523sxGrYY6fgymj3yYcaegxxhRZNUr+DoiAyVGtGZCxHQM6s0ik7AfVSc3UIv7Vh7jYUsXlfWb+j6703hC9Ley/jfbIeQDqS3+Lvcr4Ae3x4xF7XfQSdsd0qurFOD83ZxJCqxTzpZUT00XxnpkfcnkkgximaKU/3gCDjJVY7NsEiEzwSOA1YZHOyKlJ6+tyWqXk0L1qB8WM6lViYvH1vIJb0LVL1YHr9wb/wAkqdTwFrNonYTTm+hLRljnUDj2g+wxqbkjQmdp3G4iH+B8f5IfXtMzzviAYMde0eqqtjlxU2ybxZV7NYjKxFSvHhBj180hSjBeF9d9XQicsDM9pB2RjCkXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b9eeb9-a949-4976-800d-08db8405a9fb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 01:00:06.6161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SQAZWD9EwhBfq+GF/m1cmnIvnz2KqKa1q50szGztP4MDyYWYJdG3mOSYG/2lF8j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4062
X-OriginatorOrg: ddn.com
X-BESS-ID: 1689298225-105623-5442-43553-1
X-BESS-VER: 2019.1_20230712.1926
X-BESS-Apparent-Source-IP: 104.47.66.49
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaG5gZAVgZQMNXQMtU0zcLS1N
        TYzNLc0CA1JdksJdXAwMgwxSjVwjxRqTYWAL0qd9RBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.249470 [from 
        cloudscan19-173.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Emoly Liu <emoly@whamcloud.com>

In function ext2fs_image_super_read(), the size of block group
descriptors should be (fs->blocksize * fs->desc_blocks), but not
(fs->blocksize * fs->group_desc_count).

Signed-off-by: Emoly Liu <emoly@whamcloud.com>
---
 lib/ext2fs/imager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/ext2fs/imager.c b/lib/ext2fs/imager.c
index 23290a6a..16b09770 100644
--- a/lib/ext2fs/imager.c
+++ b/lib/ext2fs/imager.c
@@ -299,7 +299,7 @@ errcode_t ext2fs_image_super_read(ext2_filsys fs, int fd,
        ssize_t         actual, size;
        errcode_t       retval;

-       size = (ssize_t)fs->blocksize * (fs->group_desc_count + 1);
+       size = (ssize_t)fs->blocksize * (fs->desc_blocks + 1);
        buf = malloc(size);
        if (!buf)
                return ENOMEM;
@@ -323,7 +323,7 @@ errcode_t ext2fs_image_super_read(ext2_filsys fs, int fd,
        memcpy(fs->super, buf, SUPERBLOCK_SIZE);

        memcpy(fs->group_desc, buf + fs->blocksize,
-              (ssize_t)fs->blocksize * fs->group_desc_count);
+              (ssize_t)fs->blocksize * fs->desc_blocks);

        retval = 0;

-- 
2.41.0

