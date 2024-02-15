Return-Path: <linux-ext4+bounces-1247-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2221856344
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Feb 2024 13:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99ED92886D8
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Feb 2024 12:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8418312CD84;
	Thu, 15 Feb 2024 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P/dzkG3M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qX/LOenS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3377869B;
	Thu, 15 Feb 2024 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000452; cv=fail; b=q4YgwrKeDTfLuYttKGLTbtSqVJkbsAQ32wQdrDJ73MAcesYmzRnsgRi1qmkx5P/wCFErotfqvKytclqup1G5YrU7wiiXojO9aD4Ry5ROLQjMZHQJkpUbILLN4iKs2FaduBIRtFvOxq80dgDSmhLE9iT77U7/gvVm5hTj0im0s40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000452; c=relaxed/simple;
	bh=OtxEdL/tiO3idtbcoVtafWfj2QUG3CCLrnElCHB9uCk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A8Pix0Ak8s/Ht9Zyy0ZiEUI3LVBQp2Ujk/uLfaqBkTcWchQSMun75tzQ2AuoizAU+hpeQVWMaQcx6MzLT8Y5YQBHaXr3k2xTvrExNJs4r5GqvYjVWG5+0emWYie8tUnS9hsgwskBKPpj05UPTKRUBQltu74VedPcYrWvm/w6rCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P/dzkG3M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qX/LOenS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41F6i0Gs001409;
	Thu, 15 Feb 2024 12:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TiAPRoE+k7u470QfN+2VMA5L9m0z5n7iQUrk2c7YSRQ=;
 b=P/dzkG3MB1Jnn+qzs0cSvNGhzq5Rebfdr+k0ZJde6MkLrpjXF6ocY9x73Ted10ce1Cxq
 3eP/1EdDV9QtuaIydacypge8DWV1EURUQxSJN7S22kBs/7UmLC3grGq0kq52j+/EuX9L
 mrGCjKQ/Upa9kV1dOJwrj0xfcnpVGvr2clq+QKacPX8AtogrFCS5kOopCfYszFQCEXSq
 rwhs8uo/2H5lH1jeOVV0I0U/Qsa+iJKkjYL1Q0+liKY6PiA5H9b9JsrizuWJvgBGK7DH
 A2rzbfirK8sAd8E8hIyAxopP9GaS+0y1LCrqUc5Bgd+iEH+wXTnkkEvuPHDoyRfGFEKa tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w9301hyf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 12:34:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FCNPxM014968;
	Thu, 15 Feb 2024 12:34:04 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yka5qdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 12:34:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/NIECsW3SOVBj7RJ5SEr7TXttrdlIJJe56TzXHGGL1xAVKfT2iwfplTuW3IrWxx97kVdBBEReFofVqGQuM6f4KPuNO2nHnVDa0V16VQCecDmDDiklM8onkkw8PUQWQ36vJJYtzIIi7Qrm3j8OciziDroKxgayXRJtShtglmw+9nv0TLemmb/0QBHM9Hh+Uk7o4fdCK2B7dOY42doMX5mgjehf/6kr+TGzsHQs+1suTo647ceV7sptZ8qSQBByrcRBjQrv0UMgCLZAKW1wsDcLd6h6miwBMtMiD3ceeF3j+FGftqfH5YTrWCAXl7oMixm/6E07TBvFXOjaAvCOcOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiAPRoE+k7u470QfN+2VMA5L9m0z5n7iQUrk2c7YSRQ=;
 b=IikBI+3yLGw+Xh8s/yogu7ynS1B29BZzqlw51hUW47J4Ow9jbwdXY3UruodZ5h0MV18zvLDolX4ovhhJtpirKPAiepW6iwO3qrkgo3c4/eaEkRH5Dr9iqPRninS6AP39a/knOXG6/TcC8/AFXYKdRpGgWk7Nfpt+odj7jgoh4F+XnGK2yvSOQ3FCOqNk9sMjauO3EBZMXLAouIbj06pqtv3DsBi1A6omBkTHBfW5J0aVt4QbCYngt0susNAOLUGP4We/ovBibjzXAlgE4OtiN6CO8rdwTspo9Xp1WPP/Fbn3lK2JnpR+2RlA6avs/0gZVuEi18ZADUKM4hSSr1E0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiAPRoE+k7u470QfN+2VMA5L9m0z5n7iQUrk2c7YSRQ=;
 b=qX/LOenSQ4IRdCCI6Uq1IIMLMNruxOmsb9P37y4hILSnOlUTsvuok1DHf82UR0gaEDNKRMAquAKD19UxdP0Lck35rUNOR32yJQhIAy6JG/oXmj1tSzyTkDt93tk34XlbCsigf+BCD5BfuuR6vSwOytaLW4N0V0E4+eQmOxXjdBA=
Received: from DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11)
 by SA3PR10MB6997.namprd10.prod.outlook.com (2603:10b6:806:31a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 12:34:01 +0000
Received: from DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::968:7850:920:4462]) by DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::968:7850:920:4462%6]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 12:34:01 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: Maximilian Heyne <mheyne@amazon.de>
CC: "ravib@amazon.com" <ravib@amazon.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Rajesh Sivaramasubramaniom
	<rajesh.sivaramasubramaniom@oracle.com>,
        Junxiao Bi <junxiao.bi@oracle.com>
Subject: RE: [External] : [PATCH] ext4: fix corruption during on-line resize
Thread-Topic: [External] : [PATCH] ext4: fix corruption during on-line resize
Thread-Index: AQHaWPVja2Juw9htvkCjWHcAtaz45bELXOww
Date: Thu, 15 Feb 2024 12:34:01 +0000
Message-ID: 
 <DM6PR10MB4347201178CDE8E57FC77EBFA04D2@DM6PR10MB4347.namprd10.prod.outlook.com>
References: <20240206120504.122870-1-mheyne@amazon.de>
In-Reply-To: <20240206120504.122870-1-mheyne@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR10MB4347:EE_|SA3PR10MB6997:EE_
x-ms-office365-filtering-correlation-id: 0d89114f-1011-43e0-35ef-08dc2e226386
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lg9AeCNYXMN2MkLx2dAb1fY2e3dHVVSmQPiiShEe+QSlGFr6evMV61rQLVbPxhUm7Wc9lDSxDSEOY2A4kOdX0/dTjK6FOIvTwM+zfCVJsoXfy08T4yiosdAc81Qo+Ai+TbRrUXBR6WpADNvW3G3HI1F09unLo5x/4wf1hO95G1rNzCuhrZITgWoaZgYetKzNuIKMMM4r7MOcOxwvJakVyLBvRn8By+rYQJP/UKNQlTTVdS6Mqnca2q0IYpFgaTkCb/60IX277tTZKYK+1tGl8Yw1fjpNNcC9BFtqNAnRpM4uI/cw72FpnPQM/Q0pX3Aspja3qpMdWrGsphNOOLWjz2FMT8NFldcXun8DrVEa7HBOfsz7plgLk3lUj6sBFnwCVqlEgmFld1OE4EGhVEXTtOel/r76FDR6XhSB+Wv18SrXwJIiWNHkPH/e5Y+S7IYjzicRNgghc/vQgr3GVoHlGzJ3XNl62l79k3URDCz14PLbAq5Fd6DvyIKoxdIsSofDon0TpK+nplVZ1SIwdAwEZWdpZjbPn3AtqK7NOr2Fwp90VlMAMQm1nKxFzJkfiUSshtnqHzviDibfVzWF3vC3/kJ62c4zWM3ywWccVGkZogKhmEJjKlge132FZ7kVfo9B
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4347.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(5660300002)(54906003)(316002)(52536014)(41300700001)(2906002)(26005)(86362001)(83380400001)(122000001)(33656002)(38100700002)(66446008)(38070700009)(71200400001)(107886003)(66476007)(8676002)(8936002)(4326008)(66556008)(6916009)(66946007)(64756008)(76116006)(478600001)(7696005)(6506007)(9686003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?L/Er46KD3D9aVL2wiaqsB9Ch5slPtAewEvVLoCqGtrHziZpbO7AF4Jr+cYkX?=
 =?us-ascii?Q?MM7Txgafjctr37Fx1u1KKUnoa+FEMTsPfvnWkKRNX7qeED34+BWM1T6L9eKG?=
 =?us-ascii?Q?eOJxu6pluzFVu4mYvmzaVVZySEpzqCtBDmhdtv/8tWe66mnC9LNUpx7sl1iI?=
 =?us-ascii?Q?TZE5hmf2eexvKjUBpS8C7iz3WabAXqsutIE9ahTk+FvpQ83Ccg2joHum12fl?=
 =?us-ascii?Q?gUiYoEfOO0Hi1QlJ6ZAaCQEJSC0A5g/TV1IIXiErO8zpTNCb1Isax4/HaMGH?=
 =?us-ascii?Q?SP5yNazqwTXH6mm7Qsy4pHqQPJP6xgR9Aq0S/bEzbDrGV4EQSoepymCSamzE?=
 =?us-ascii?Q?zQ7MukLs35OaNH/e8mpiJ+FA57CHl/nrNBf0FdA1kAvHziJE94re+XdTqCIV?=
 =?us-ascii?Q?PnTr5jb7HdoKJp8S5rt9JxmQE4fxUBmczoKYvgO/nvXoI5Hs0BiFsMPWZQpk?=
 =?us-ascii?Q?gcTupE7BN7obk1twVjwTlz7trSM5LUvz0IEuHhNliby1uPTAHefdcbXcp20P?=
 =?us-ascii?Q?jLPQBhT2kkAUZsY/DVaTLEDZZ+HuTFcAIDxhMH08G9xzNL4XAOvqWX+c7wI+?=
 =?us-ascii?Q?4yuJqADG7OccwlK3d1UMQeeqJgPZJ8BaFYBkpHIWT9S9nu3lJRyIB9TBLHcg?=
 =?us-ascii?Q?iiMwgXAFOhxIPCnV5bB6WWWBH4u658ED2XMTAtcalshfNx/4QWNF2KRxq6TW?=
 =?us-ascii?Q?FnZAWGkGiv0yurbprX/n0oq6KBP6vvNY1SSpTjq6gRmqVhoGoT4ciNZ7GuTz?=
 =?us-ascii?Q?+zZClUchsKfbiD3+WqG6Wz7hfOMORiAlue/7XSTlobMw5ETr401dV/V8xse+?=
 =?us-ascii?Q?uJ1c3fCukbNWRi3Iz4RJshT8wNokUcBEX6oiywk9+bjQW8o7a5PAVtj9FNyO?=
 =?us-ascii?Q?71sMRNzPuIWCLWxCw2ilYhs7bXOBL9RPU4lKQwbDvuNRWG8E3oNRQy4xUWoe?=
 =?us-ascii?Q?LqDTiwAV/G1UeJ0sC8x7nZQjwLuDKRM0L94mFx8chkFY0WE/jmmcrtYKlrxv?=
 =?us-ascii?Q?NPnKgiLow55d4vN7X/nLfGg0wxvPcCIAi84Quo1Ddae7PuhzeQfxtb2oFiAT?=
 =?us-ascii?Q?nFfznHUY1wShL6apX/76OYtiL3s3gG4CouXs61npoQ1JoLu08zaccRne8Ddq?=
 =?us-ascii?Q?9QSD4P4zAZ8vq2lc7rsXMXysDieaIUksx5/Wt0nhQ10Cl89jugONKRkgSh7w?=
 =?us-ascii?Q?3qahqFD5g0lP4GLs5bn3wcz3tDqGxd4nywjJTTVtpxRAs5/em3Fb9uPXMUI1?=
 =?us-ascii?Q?qRp0Y4VGF3WCNJWN1jxCY8Kt7JZBuDGK/9rt6MSGYsXIwtbqh3cuK5EYdP4X?=
 =?us-ascii?Q?HocugDN/74Y9kg23604R7QxanY4gYkEQmOSMXhta69ei1vygy2U01r6Evadq?=
 =?us-ascii?Q?CwH/aEs7e7fWbRUJWXCZSNFSrAS3rwBuVvuJH9l0GeToUVtK44N3DvAtquW2?=
 =?us-ascii?Q?aTO+Zm8mzv/RGivCc+9SK/Gp7efmwNtaoMxRdGZHMAGnxnFhZG8sj/RR0XBA?=
 =?us-ascii?Q?3FgqmzKws2HhZqUXCL1dCrDGsUMXqVSICGddDsniE2aT8eC8YBHa77SJpG3q?=
 =?us-ascii?Q?MWnzM1/dsak78AI+/1nbHJt4L9e4LNy4f9PSUIOB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	D3nsv2Mly7wZv5LxIS7nfcrugPNwHZeH9ogy59gzQSOgFRtHrWRlHjZrgWufCqEfpTP/aPLh/Bn+yvgqDpBz4LPpcNv9Sc/GeIFL4cSQWbJdOm1Vh4vi5CmCK27afGZU72xpJeES33/py3hyrexawaEEjdJDBG3qvei0k3EpbRuNB9UwzvI4sj3Gpb47DGZU0D3z9CDScRqldaNUsxcXuliNBNtmmHhBcXNeSo1wEDn3X4tE7Kq1q4UrXym7yufDoYveO6NhT1B39dLOe3HudkLU4wweLFn6lvJQ+dQGJVXzoobeDcJFqwXYIHNwk7D1XMBpndKdg1DTqIKFxv5nEeXxliYMzA8Q1ZIV0xFNKD5KeI/2jKYvCU8f3Lt3fte0zeVLEJ1CYsXMbsvLSs/tYiLicVedDwSu1lpVmHqM1M3fTD/06TkFNXq7f+u3L2yV/1zQcdtYEEOfevxJR7I24LCIV7VOfuZJgD6OlPQOyFl4Aq7ht+tFjeGa04lgcVSFWKMjnWF4sqdUNRNBpZOjp+cIkrvdWK1u4t93aGipMWhZXj2glIdc9IaRpMDvzY9r/7bTyPC6kN1BjSImYMAGC4wY86j4IqfWNkOLWO/qK5o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4347.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d89114f-1011-43e0-35ef-08dc2e226386
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 12:34:01.2881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 577jAks24gHmQUWhGq9XdQhl7P+DGapAdBUk7BHNHJyxfc3KUbvnAxg5vT/XEcjfbeylI1FBjrAuHAkW8VWiN+vtLn+IT6r77gNlmKlIXD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_11,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150100
X-Proofpoint-GUID: P72YR-mcEDWOYc6oHFerYzg-LwOY1y0U
X-Proofpoint-ORIG-GUID: P72YR-mcEDWOYc6oHFerYzg-LwOY1y0U

On Tue, 2024-02-06 at 12:05 +0000, Maximilian Heyne wrote:
> We observed a corruption during on-line resize of a file system that is
> larger than 16 TiB with 4k block size. With having more then 2^32 blocks
> resize_inode is turned off by default by mke2fs. The issue can be
> reproduced on a smaller file system for convenience by explicitly
> turning off resize_inode. An on-line resize across an 8 GiB boundary (the
> size of a meta block group in this setup) then leads to a corruption:
>
>   dev=3D/dev/<some_dev> # should be >=3D 16 GiB
>   mkdir -p /corruption
>   /sbin/mke2fs -t ext4 -b 4096 -O ^resize_inode $dev $((2 * 2**21 - 2**15=
))
>   mount -t ext4 $dev /corruption
>
>   dd if=3D/dev/zero bs=3D4096 of=3D/corruption/test count=3D$((2*2**21 - =
4*2**15))
Tip: Use fallocate for faster allocations.

>   sha1sum /corruption/test
>   # 79d2658b39dcfd77274e435b0934028adafaab11  /corruption/test
>
>   /sbin/resize2fs $dev $((2*2**21))
>   # drop page cache to force reload the block from disk
>   echo 1 > /proc/sys/vm/drop_caches
>
>   sha1sum /corruption/test
>   # 3c2abc63cbf1a94c9e6977e0fbd72cd832c4d5c3  /corruption/test
>
> 2^21 =3D 2^15*2^6 equals 8 GiB whereof 2^15 is the number of blocks per
> block group and 2^6 are the number of block groups that make a meta
> block group.
>
> The last checksum might be different depending on how the file is laid
> out across the physical blocks. The actual corruption occurs at physical
> block 63*2^15 =3D 2064384 which would be the location of the backup of th=
e
> meta block group's block descriptor. During the on-line resize the file
> system will be converted to meta_bg starting at s_first_meta_bg which is
> 2 in the example - meaning all block groups after 16 GiB. However, in
> ext4_flex_group_add we might add block groups that are not part of the
> first meta block group yet. In the reproducer we achieved this by
> substracting the size of a whole block group from the point where the
> meta block group would start. This must be considered when updating the
> backup block group descriptors to follow the non-meta_bg layout. The fix
> is to add a test whether the group to add is already part of the meta
> block group or not.
>
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> ---
>  fs/ext4/resize.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 4d4a5a32e310..3433e83bb7a3 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -1602,7 +1602,9 @@ static int ext4_flex_group_add(struct super_block *=
sb,
>                 int gdb_num =3D group / EXT4_DESC_PER_BLOCK(sb);
>                 int gdb_num_end =3D ((group + flex_gd->count - 1) /
>                                    EXT4_DESC_PER_BLOCK(sb));
> -               int meta_bg =3D ext4_has_feature_meta_bg(sb);
> +               unsigned long metagroup =3D group / EXT4_DESC_PER_BLOCK(s=
b);
> +               int meta_bg =3D ext4_has_feature_meta_bg(sb) &&
> +                             metagroup >=3D le32_to_cpu(es->s_first_meta=
_bg);

Instead of creating a new variable, please use existing variable `gdb_num`.

>                 sector_t padding_blocks =3D meta_bg ? 0 : sbi->s_sbh->b_b=
locknr -
>                                          ext4_group_first_block_no(sb, 0)=
;
> --
> 2.40.1

Have tested it on different filesystem setups, it does stop corruption.

>
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879

