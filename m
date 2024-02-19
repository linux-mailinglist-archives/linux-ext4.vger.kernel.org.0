Return-Path: <linux-ext4+bounces-1269-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C3C859C8D
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Feb 2024 08:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE27A280FEF
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Feb 2024 07:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81457208A8;
	Mon, 19 Feb 2024 07:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IGS0e80c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EvT2RSmU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094422031C;
	Mon, 19 Feb 2024 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708326396; cv=fail; b=AWC+Sb/7WA/WUZ+pc12YDP9z/P9tENV5StXpPAwX0xKXrl35gTJAvjne+a/zGVHWvwQgVjaCjSzih7ZWRLhysQsv7IUzL6wiccj3Ru8gLHOleObkMUZhll4bu6eo9VUqcUJbym+ukbuYip8V68ICrTUQ/t1GTsJqJOg1KULsSRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708326396; c=relaxed/simple;
	bh=ZLk5pdtfzFBOuQ5qWUQJObUSu9i8Z9FO4g6kkCe7bEs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gbkVVqDmy0ij1maP7QRywNWDkje+vtpfS+ZvkteS33nSog5WKgpXao8Zht6i2kTaltqxgE1riiJIY07I/qcloayvcHnWGyM80rfNrDojObKyBvQn02pMzvsoP9JRMwlNXB6yCN1V6Qcqnog+B9FhUh0tCYpfuraDvSjJjgvQlx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IGS0e80c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EvT2RSmU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41J6pIar021829;
	Mon, 19 Feb 2024 07:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=CWVS3+o6GKeQ2wv92il4La7lcBLOwdc1gd/bn2dnoYk=;
 b=IGS0e80cd0ZDgPMt6WI8R2AYAODb3U/G5aewitk7rvVNyq26RYqbpcqp/deIipgVQFNU
 woSsUFM61DPLIDvtyk7SPHW9sJOuyn9XjQbIXkYVG8hR2LZwR9n/bV33hMWFjDwBkvcx
 j6BGJ4jyTn6g6URJM4tafrAcELbqunSvIdwcEoNEoFsM6QA8YnfFjXkT+WMrp1vPkp0g
 FpYY7xVE04D0kKGRnZQAGsH3JywRDkoVltOXznnyy7zV5jqkeX3Ggf+sQiLSZmA/+1+x
 srwrJHMhTDIZ5j8VtOybTLifCJyL4zdyv9dDt3C/C9M1pKHYKu7DCXn8Y8NdEy5hIP3a FA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wanbvb8pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 07:06:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41J6ix9n029144;
	Mon, 19 Feb 2024 07:06:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak85qsef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 07:06:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DR2nb7osLML5NoTg/t5HOvDDKe3Gq4eQ+V2Rp+wMWK/rSPUG9OfdKO2DyXQ2oOim34wZI3jBTYb3Rd26or4aEBR3cAX36aBwccx83nnjDmiu5jQrLU7azFyQQsRhF75bjsybdZfSYQzIdRAm3fVeQ6ggG2gMKbcF1FqXSFU+34AGfJI4aJ7jjpoyZZP/C7qk9BwAkGN60qwnJCu0QkBFWd0llj3WaI7IjvQw8ZOnU2og0pSbfrltyzYe5CdQ9SzgUIL59opcCJ/YDZlu3hss1mk3wTi6yz3vYyzShPoamHc8B90DyKr4GyOHUOUi+xtpC+zdAqhmix9bbbjr9hxBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWVS3+o6GKeQ2wv92il4La7lcBLOwdc1gd/bn2dnoYk=;
 b=Jq5r4+Pu3mRa7CR21qZ9RDJ/J8DzZkKWoxMcRngycf4iMJdxIRSpyZcwEZE3pyLO+Qp6zmLnSUpi3g/sW+lSWMLPgvKJB0lqYkqrwvrNMBc3DF9jeqjrsQ8EScYdaEMzB7NvxHeXKfHolXY5yCHL6sx1GAqsD8JmO9F96ZkEtABUrfqWmaydplWDqREvSKlX5FncEK75NaBrzR6u2wLljYnBhM61yEM5Qo4cYXMIWaSsyKjoH81iXLshEuzRqEUqbB2tM0xOvPzTai1JCmK2y+ct1+NbUdFa0/6ML+KAPM+h56O3oyE7mJgJZwDmhPakHQwZDgsybqAVn3aqbwUN8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWVS3+o6GKeQ2wv92il4La7lcBLOwdc1gd/bn2dnoYk=;
 b=EvT2RSmU64j8TvOp4IegGUB5c2ymkyUfudfH8P9GPPXaa59nqnCmpT60ucaGqbPWDkc4Tq3a9HnS5fVlR6Mn0WPCkioujoHJFHwGdWcMIakUWldeydodBK5nIPIKAEs62sWj1zYxyFvxzvvt1CJN+BTk3W5okYtU4DicQGDrNjA=
Received: from MN2PR10MB4349.namprd10.prod.outlook.com (2603:10b6:208:1d4::9)
 by CH0PR10MB4955.namprd10.prod.outlook.com (2603:10b6:610:c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 19 Feb
 2024 07:06:17 +0000
Received: from MN2PR10MB4349.namprd10.prod.outlook.com
 ([fe80::2b25:4b29:73ac:20fd]) by MN2PR10MB4349.namprd10.prod.outlook.com
 ([fe80::2b25:4b29:73ac:20fd%6]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 07:06:17 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: Maximilian Heyne <mheyne@amazon.de>
CC: "ravib@amazon.com" <ravib@amazon.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger
	<adilger.kernel@dilger.ca>,
        Yongqiang Yang <xiaoqiangnk@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajesh
 Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Junxiao Bi
	<junxiao.bi@oracle.com>
Subject: RE: [External] : [PATCH v2] ext4: fix corruption during on-line
 resize
Thread-Topic: [External] : [PATCH v2] ext4: fix corruption during on-line
 resize
Thread-Index: AQHaYCdv+HKdg+s0OE+j5sdgQBPcPbERQ2lw
Date: Mon, 19 Feb 2024 07:06:17 +0000
Message-ID: 
 <MN2PR10MB4349049992351787B0E5F83AA0512@MN2PR10MB4349.namprd10.prod.outlook.com>
References: <20240215155009.94493-1-mheyne@amazon.de>
In-Reply-To: <20240215155009.94493-1-mheyne@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR10MB4349:EE_|CH0PR10MB4955:EE_
x-ms-office365-filtering-correlation-id: c842881b-0c72-4ea1-15ca-08dc31194469
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QkJgb93nYStjOu02dZyS05Mb7o2L/OlxwPPrQ/X5HfYYXMIyTlIqKepFthxKwJZZqEGTX37XIVFkqTEbeYnU90Rc/t466vyELxStHWhFXw4eaOntldZZVMR/4bm5XkJbI93XDYlGvme08v8kAEKy6BbCieOrzC84/hiNh9F65OMLASrKGEy699jo1wOKL5+EYaiEUoiOZTESQORY5+dnQfsNdjr240VCkirkXWrrpyoor67PgfUU9gxhgn+K665taKtsFHRcbsVb+Hf/GPomgpuQe2esV+dXS+F3G8W9A1gormvA8klS3pd2psFUIzBdCsgPwLie++5/z4IzDA6tJmGoqxpLHIup8txQfrSbw8NRvdu5mHE5fHUWn6NZylKijYywX22hKTULKj2wx3NdpJ3vi/KCM1frFAw8/80YM5nmBbMw9ZLkqAEnzXoFSojbSZocwvPSDwlyvU+yC4O7PA/P9tISTYc1h7ALcVpAAcgtdv9T+rVLf1oOQV7xHKQ5Uu7aVEF+44CF5CuONmKznSpGcoUnIc3sJImR8aTFbYdOHuhzCweVhMDtYPtMLBf3dhHwrD7sn8ozqsRVDxOVI4KDDWaKO2p7lHwE3K42RFyFRiHjL5/wlWrdBEn8hXhw
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4349.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(136003)(366004)(230273577357003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(38070700009)(8676002)(26005)(41300700001)(107886003)(83380400001)(316002)(66556008)(8936002)(52536014)(66476007)(66446008)(64756008)(66946007)(4326008)(6916009)(76116006)(478600001)(9686003)(71200400001)(54906003)(6506007)(7696005)(33656002)(122000001)(38100700002)(86362001)(2906002)(5660300002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?nldK1WxpqjsuUWq8U5+PmzFHjxwXGp0ZD4Dkz9IxB8d2PXAuZHjyNWgd9Jkd?=
 =?us-ascii?Q?Szsf/Medz2YXHHQ0mmoNupgUOGwkFAva2VFDe+TjZtI7CcVwPUraQzcGCjix?=
 =?us-ascii?Q?JFsirXklrg2enlD0VJvt1ro39U3XjmMl68Gv1OGSco91ZlPvhhdYTL5d2fCs?=
 =?us-ascii?Q?0SKHVkk8cae9Z6iPS7zzcwzuvGsNQLgVCU/xmbPW1Sn+rIs+eBaPzYyQkNjQ?=
 =?us-ascii?Q?DkX9dM3bDd8zknB28oRWafyCmc2NFYuOtclcNPVaNoM+mnm+TDwqU4kncB+q?=
 =?us-ascii?Q?lNSU2zGFsIHU85nKZAgK/R6CIln58pvpx8ZWwKsCU8QKJRxzq9KVOaN+jox2?=
 =?us-ascii?Q?dEadDzXInBxend9sJz2xUGis6zjxdIlRpjaWPlCxwjvvcsqr23B4UJGPyNLE?=
 =?us-ascii?Q?MIHyzk4a6O9MQeYHqCUDZWlVp8gK/lSy/qJ8drXHE0O1KM+Saangk7/ZYNm4?=
 =?us-ascii?Q?6fpD4yPyu1qYgisK3UyhZmauUCfRLpx0sMrjRx5X4ufO00Q/k57sebgPdlwN?=
 =?us-ascii?Q?2fljFt8g5uC9V+88gTVpRcd9D5qaVhYNFVbZdKAr6HideWMQ7PdYGbmUmDI8?=
 =?us-ascii?Q?KSxt567P7xSz6rqqajIYSZrJ4VAsKxxYDeFlKA5sUIKDBrGRy3SI1GD02xhF?=
 =?us-ascii?Q?0X4rtHBkYNqNJ5j1/XAGfK/kmYnxhhM25XZF73YowEvdvYPpeRuUX10Pgueh?=
 =?us-ascii?Q?4FM6dCUBw2l7SUvFiisAWrY8umNIQLPwuc8tQVVyKpJPML3jIFXvwrx+11Pj?=
 =?us-ascii?Q?uAUcozLluyTyASg1BhCPJzRdfvJyswxgFWAfny1VZf+SE/gY61Y9TYl1Vtzn?=
 =?us-ascii?Q?qXAJtuKuuwinHyIsjVFubu4auFQ3NTACqLNBFFcWYORkLHN5IwVsy03ONfQv?=
 =?us-ascii?Q?uQDVNYO5ZKDJMiU0r3KfsOG6U1uA2Dm9/CF/oHvbMFML6Sq889dZLAOUMgJz?=
 =?us-ascii?Q?Ynpymn+1bN94rwTNbXjPeFGJvsJu1OMnDPZPHpMCbQqhBibVonBFhvm/RkeH?=
 =?us-ascii?Q?j44/jUepja40C5GBtrmYLrHp/SvHAKPqfxTa+gT7n89uigreFrFnidnAZoEn?=
 =?us-ascii?Q?LVDHYTrCnrAtBzLcxAf59pfPWYDaKBAh4IFCeaq0m7SL/+XO23IJal7+s2Uu?=
 =?us-ascii?Q?vB0LlUeH81aJyADwk/BAgDu2Hvn9H4XDiL/maw1VX1+VDJRcY9VGWhyfznwg?=
 =?us-ascii?Q?NpHtHiYgeaYanQrngGO7kU39/465tZ2uy2tasDzho/Szo8zS+upjTg2kjP5s?=
 =?us-ascii?Q?Nh5JuAJ1pgtxFUSdYQOCVBuNkHEyXkytkvubR4yFS3WwxspSsCDcnhZjx3x4?=
 =?us-ascii?Q?OfgthUbadnusvBtIEM+gEfBEyCpjt2aigDXfn81xMWuIgdesKunteuq01Nkv?=
 =?us-ascii?Q?18dSTUUN9ZBM0rOxiw1cJB2XOGBJfE8TSVkXEAglGri/fJx4IeHIkOrWRQvX?=
 =?us-ascii?Q?gVJpJBVbYUbiVok7M99OgbaHpag4MLVIZPzodj+V+yZOogB7Umvub/k9oPqh?=
 =?us-ascii?Q?rlOBulORHgZZbVjSVkjyDE2zFrF9c50UpTvZkG1mw+AFPdtqqr0NxLTEqXjK?=
 =?us-ascii?Q?qNKDZi80nZhNWBCrN7T56XatE047RC74pLOhATRRga2sgJZ5ARl9lTzGHyO4?=
 =?us-ascii?Q?kA=3D=3D?=
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
	VsNXOLJg+po6uF5ovMSf/HVrcR048VJ7fShF5UzIrotHATt2SrjlR3M2oWKmWph87RAkSy/r4sUitWGnASF/YACcLgQ3I2Gznhhw+wOGSZCV2bFCX38aGJh2TfkOAjHzwpda7q4KAaGKyZ1fQtqLb/2+qpfzaMQFHthkX3JQT2+0d4wyBpDhWy15WWA56wnPj8jzquNmVqt9yCrM0x1M3xHod16OmBPwCy/sYnLVaZPUUaLACk8tF605UG8Eq3PsOthW3eB303cjJru1e31ziawYiMouPm3z1iQj5rKZMjK92Rc4fc90RR8rl7rtihJX9bJcbRPuEzkI+rKen0zxMlHCYx39eSHPvweXbTEF5Il2aGgAIWrakbS6yzpbI3+kdAzu7h3Q899XIcOdstAI/cxXLslzdptu+AkFCm46aCIwiYsNPtshumyZnz+nYlaIpRGJkbSXVT9XjEaj74ugZy4rXkW651GUKqecETHA9NgVHb1iOE2munmYIL0GEw0OfbD4iYGe79dlFgVySmdtU0QTLPqwQL0jwVW79Fe70gPjSWSUnBV7fVDCIA8KWDq1p96j+Hoq616+zo/pNUbLyOsd29GipfbLOzJi+0ONqtk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4349.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c842881b-0c72-4ea1-15ca-08dc31194469
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 07:06:17.1302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6udeOLfvfzyVEwF4FyNvT6eidl+pPdjUoGJKKzjsB1i84lSa5A1KiKzqWLm+K6unYSaf/O/v40///U8zp/7J4dS3pV5YFWn8YtvlqztG12w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_04,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190052
X-Proofpoint-GUID: W4uyKVQGCsFVZkKxuSijkDwSl--OiS83
X-Proofpoint-ORIG-GUID: W4uyKVQGCsFVZkKxuSijkDwSl--OiS83


-----Original Message-----
From: Maximilian Heyne <mheyne@amazon.de>=20
Sent: Thursday, February 15, 2024 9:20 PM
Cc: ravib@amazon.com; Maximilian Heyne <mheyne@amazon.de>;=20
stable@vger.kernel.org; Theodore Ts'o <tytso@mit.edu>; Andreas Dilger=20
<adilger.kernel@dilger.ca>; Yongqiang Yang <xiaoqiangnk@gmail.com>;=20
linux-ext4@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: [External] : [PATCH v2] ext4: fix corruption during on-line resize

> We observed a corruption during on-line resize of a file system that is
> larger than 16 TiB with 4k block size. With having more then 2^32 blocks
> resize_inode is turned off by default by mke2fs. The issue can be
> reproduced on a smaller file system for convenience by explicitly
> turning off resize_inode. An on-line resize across an 8 GiB boundary (the
> size of a meta block group in this setup) then leads to a corruption:
>
>  dev=3D/dev/<some_dev> # should be >=3D 16 GiB
>  mkdir -p /corruption
>  /sbin/mke2fs -t ext4 -b 4096 -O ^resize_inode $dev $((2 * 2**21 - 2**15)=
)
>  mount -t ext4 $dev /corruption
>
>  dd if=3D/dev/zero bs=3D4096 of=3D/corruption/test count=3D$((2*2**21 - 4=
*2**15))
>  sha1sum /corruption/test
>  # 79d2658b39dcfd77274e435b0934028adafaab11  /corruption/test
>
>  /sbin/resize2fs $dev $((2*2**21))
>  # drop page cache to force reload the block from disk
>  echo 1 > /proc/sys/vm/drop_caches
>
>  sha1sum /corruption/test
>  # 3c2abc63cbf1a94c9e6977e0fbd72cd832c4d5c3  /corruption/test
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
> Fixes: 01f795f9e0d67 ("ext4: add online resizing support for meta_bg and =
64-bit file systems")
> Cc: stable@vger.kernel.org

Tested the patch across filesystem of various sizes and blocksizes. The pat=
ch stops
the corruption.

> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>

Tested-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
Reviewed-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>

> ---
> fs/ext4/resize.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 4d4a5a32e310..3c0d12382e06 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -1602,7 +1602,8 @@ static int ext4_flex_group_add(struct super_block *=
sb,
> 		int gdb_num =3D group / EXT4_DESC_PER_BLOCK(sb);
> 		int gdb_num_end =3D ((group + flex_gd->count - 1) /
> 				   EXT4_DESC_PER_BLOCK(sb));
> -		int meta_bg =3D ext4_has_feature_meta_bg(sb);
> +		int meta_bg =3D ext4_has_feature_meta_bg(sb) &&
> +			      gdb_num >=3D le32_to_cpu(es->s_first_meta_bg);
> 		sector_t padding_blocks =3D meta_bg ? 0 : sbi->s_sbh->b_blocknr -
> 					 ext4_group_first_block_no(sb, 0);
>=20
> --=20
> 2.40.1
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

